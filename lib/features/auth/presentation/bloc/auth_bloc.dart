import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/validators/validators.dart';
import '../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/get_persisted_user_usercase.dart';
import '../../domain/usecase/google_auth_usecase.dart';
import '../../domain/usecase/linked_auth_usecase.dart';
import '../../domain/usecase/login_email_usercase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UCGetPersistedUser persistedUser;
  final UCAuthLinkedIn authLinkedIn;
  final UCGoogleAuth authGoogle;
  final UCLoginEmail loginEmail;
  final UCGetSocialAuthToken socialAuthToken;

  AuthBloc({
    @required this.persistedUser,
    @required this.authLinkedIn,
    @required this.authGoogle,
    @required this.loginEmail,
    @required this.socialAuthToken,
  })  : assert(persistedUser != null),
        assert(authLinkedIn != null),
        assert(authGoogle != null),
        assert(loginEmail != null),
        assert(socialAuthToken != null),
        super(const AuthStateInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState(event);
    } else if (event is AuthEmailChanged) {
      yield* _mapAuthEmailChangedToState(event);
    } else if (event is AuthPaswordChanged) {
      yield* _mapAuthPasswordChangedToState(event);
    } else if (event is AuthSocialPressed) {
      yield* _mapSocialAuthToState(event);
    } else if (event is AuthLoginEmailPressed) {
      yield* _mapLoginEmailToState(event);
    }
  }

  // Helper

  Future<String> getOnseSignalOsId() async {
    final onesignalSub =
        await OneSignal.shared.getPermissionSubscriptionState();
    return onesignalSub.subscriptionStatus.userId;
  }

  Stream<AuthState> _mapAuthStartedToState(AuthStarted event) async* {
    final userOrError = await persistedUser(NoParams());
    yield userOrError.fold(
      (failure) => const AuthStateFailure(),
      (user) => AuthStateSuccess(user: user),
    );
  }

  Stream<AuthState> _mapAuthEmailChangedToState(AuthEmailChanged event) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(event.email));
  }

  Stream<AuthState> _mapAuthPasswordChangedToState(
      AuthPaswordChanged event) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(event.password));
  }

  Stream<AuthState> _mapSocialAuthToState(AuthSocialPressed event) async* {
    final provider = event.provider;
    final osId = await getOnseSignalOsId();
    final tokenOrFailure = await socialAuthToken(
      SocialAuthTokenParams(provider: provider),
    );

    yield* tokenOrFailure.fold(
      (failure) async* {
        yield const AuthStateFailure();
      },
      (token) => _mapSocialAuthBackendCallToState(() {
        if (provider == SocialAuthProviders.google) {
          return authGoogle(GoogleAuthParams(osId: osId, token: token.token));
        } else if (provider == SocialAuthProviders.linkedin) {
          return authLinkedIn(LinkedAuthParams(osId: osId, token: token.token));
        }
        return Future.value(Left(ServerFailure()));
      }),
    );
  }

  Stream<AuthState> _mapSocialAuthBackendCallToState(
      Future<Either<Failure, User>> Function() callback) async* {
    yield state.loading();

    final respose = await callback();
    yield respose.fold(
      (failure) => const AuthStateFailure(),
      (user) => AuthStateSuccess(user: user),
    );
  }

  Stream<AuthState> _mapLoginEmailToState(AuthLoginEmailPressed event) async* {
    if (state.isFormValid) {
      yield state.loading();
      final osId = await getOnseSignalOsId();
      final userOrFailure = await loginEmail(EmailLoginParams(
        email: event.email,
        password: event.password,
        osId: osId,
      ));

      yield userOrFailure.fold(
        (failure) => const AuthStateFailure(),
        (user) => AuthStateSuccess(user: user),
      );
    }
  }
}

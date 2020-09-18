import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/domain/usecase/facebook_auth_usecase.dart';
import 'package:worknetwork/features/auth/domain/usecase/get_authentication_usecase.dart';
import 'package:worknetwork/features/auth/domain/usecase/get_user_profile_usecase.dart';
import 'package:worknetwork/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:worknetwork/features/auth/domain/usecase/register_email_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../../core/validators/validators.dart';
import '../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/google_auth_usecase.dart';
import '../../domain/usecase/linked_auth_usecase.dart';
import '../../domain/usecase/login_email_usercase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UCGetUser getUser;
  final UCGetUserProfile getUserProfile;
  final PushNotifications pushNotifications;
  final UCGetAuthentication getAuthentication;
  final UCAuthLinkedIn authLinkedIn;
  final UCGoogleAuth authGoogle;
  final UCFacebookAuth authFacebook;
  final UCLoginEmail loginEmail;
  final UCGetSocialAuthToken socialAuthToken;
  final UCRegisterEmail registerEmail;

  AuthBloc({
    @required this.getUser,
    @required this.getUserProfile,
    @required this.pushNotifications,
    @required this.getAuthentication,
    @required this.authLinkedIn,
    @required this.authGoogle,
    @required this.authFacebook,
    @required this.loginEmail,
    @required this.socialAuthToken,
    @required this.registerEmail,
  })  : assert(getUser != null),
        assert(getUserProfile != null),
        assert(pushNotifications != null),
        assert(getAuthentication != null),
        assert(authLinkedIn != null),
        assert(authGoogle != null),
        assert(authFacebook != null),
        assert(loginEmail != null),
        assert(socialAuthToken != null),
        assert(registerEmail != null),
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
    } else if (event is AuthRegisterEmailPressed) {
      yield* _mapRegisterEmailToState(event);
    } else if (event is AuthUserUpdateRecieved) {
      yield AuthStateSuccess(user: event.user, profile: state.profile);
    } else if (event is AuthUserProfileUpdateRecieved) {
      yield AuthStateSuccess(user: state.user, profile: event.profile);
    }
  }

  Stream<AuthState> _mapAuthStartedToState(AuthStarted event) async* {
    final userOrError = await getAuthentication(NoParams());
    yield* userOrError.fold(
      (failure) async* {
        yield const AuthStateFailure();
      },
      (isAuth) async* {
        if (isAuth) {
          final userOrError = await getUser(NoParams());
          yield* userOrError.fold(
            (userFailure) async* {
              yield const AuthStateFailure();
            },
            (user) async* {
              final profileOrError = await getUserProfile(NoParams());
              yield profileOrError.fold(
                (profileFailure) => AuthStateSuccess(user: user, profile: null),
                (profile) => AuthStateSuccess(user: user, profile: profile),
              );
            },
          );
        } else {
          yield const AuthStateFailure();
        }
      },
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
    final osId = await pushNotifications.getSubscribtionsToken();
    final tokenOrFailure = await socialAuthToken(
      SocialAuthTokenParams(provider: provider),
    );

    yield* tokenOrFailure.fold(
      (failure) async* {
        yield AuthRequestFailure(error: failure);
      },
      (token) => _mapSocialAuthBackendCallToState(() {
        if (provider == SocialAuthProviders.google) {
          return authGoogle(GoogleAuthParams(osId: osId, token: token.token));
        } else if (provider == SocialAuthProviders.linkedin) {
          return authLinkedIn(LinkedAuthParams(osId: osId, token: token.token));
        } else if (provider == SocialAuthProviders.facebook) {
          return authFacebook(
              FacebookAuthParams(osId: osId, token: token.token));
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
      (failure) => AuthRequestFailure(error: failure),
      (user) => AuthStateSuccess(
        user: user,
        profile: state.profile,
      ),
    );
  }

  Stream<AuthState> _mapLoginEmailToState(AuthLoginEmailPressed event) async* {
    if (state.isFormValid) {
      yield state.loading();
      final osId = await pushNotifications.getSubscribtionsToken();
      final userOrFailure = await loginEmail(EmailLoginParams(
        email: event.email,
        password: event.password,
        osId: osId,
      ));

      yield userOrFailure.fold(
        (failure) => AuthRequestFailure(error: failure),
        (user) => AuthStateSuccess(
          user: user,
          profile: state.profile,
        ),
      );
    }
  }

  Stream<AuthState> _mapRegisterEmailToState(
      AuthRegisterEmailPressed event) async* {
    if (state.isFormValid) {
      yield state.loading();
      final osId = await pushNotifications.getSubscribtionsToken();
      final registerOrFailure = await registerEmail(RegisterEmailParams(
        email: event.email,
        password: event.password,
        name: event.name,
        osId: osId,
      ));

      yield registerOrFailure.fold(
        (failure) => AuthRequestFailure(error: failure),
        (user) => AuthStateSuccess(
          user: user,
          profile: state.profile,
        ),
      );
    }
  }
}

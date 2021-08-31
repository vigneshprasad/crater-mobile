import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/analytics/analytics.dart';
import '../../../../core/analytics/anlytics_events.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/push_notfications/push_notifications.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../../core/validators/validators.dart';
import '../../../../utils/analytics_helpers.dart';
import '../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/entity/user_profile_entity.dart';
import '../../domain/usecase/apple_auth_usecase.dart';
import '../../domain/usecase/facebook_auth_usecase.dart';
import '../../domain/usecase/get_authentication_usecase.dart';
import '../../domain/usecase/get_user_profile_usecase.dart';
import '../../domain/usecase/get_user_usecase.dart';
import '../../domain/usecase/google_auth_usecase.dart';
import '../../domain/usecase/linked_auth_usecase.dart';
import '../../domain/usecase/login_email_usercase.dart';
import '../../domain/usecase/register_email_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UCGetUser getUser;
  final UCGetUserProfile getUserProfile;
  final PushNotifications pushNotifications;
  final UCGetAuthentication getAuthentication;
  final UCAuthLinkedIn authLinkedIn;
  final UCGoogleAuth authGoogle;
  final UCAuthWithApple authWithApple;
  final UCFacebookAuth authFacebook;
  final UCLoginEmail loginEmail;
  final UCGetSocialAuthToken socialAuthToken;
  final UCRegisterEmail registerEmail;
  final Analytics analytics;

  AuthBloc({
    required this.getUser,
    required this.getUserProfile,
    required this.pushNotifications,
    required this.getAuthentication,
    required this.authLinkedIn,
    required this.authGoogle,
    required this.authWithApple,
    required this.authFacebook,
    required this.loginEmail,
    required this.socialAuthToken,
    required this.registerEmail,
    required this.analytics,
  }) : super(const AuthStateInitial());

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
    } else if (event is AuthLinkedTokenRecieved) {
      yield* _mapLinkedAuthToState(event);
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
              await analytics.identify(
                  properties: getUserTraitsFromModel(user));
              yield profileOrError.fold(
                (profileFailure) => AuthStateSuccess(user: user),
                (profile) {
                  analytics.identify(
                      properties: getProfileTraitsFromModel(profile));
                  return AuthStateSuccess(user: user, profile: profile);
                },
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
    yield state.loading();
    final provider = event.provider;
    final osId = await pushNotifications.getSubscriptionToken();
    yield state.copyWith(isSubmitting: false);
    final tokenOrFailure = await socialAuthToken(
      SocialAuthTokenParams(provider: provider),
    );

    yield* tokenOrFailure.fold(
      (failure) async* {
        yield AuthRequestFailure(error: failure);
      },
      (token) => _mapSocialAuthBackendCallToState(
        () {
          if (provider == SocialAuthProviders.google) {
            return authGoogle(GoogleAuthParams(osId: osId, token: token.token));
          } else if (provider == SocialAuthProviders.linkedin) {
            return authLinkedIn(
                LinkedAuthParams(osId: osId, token: token.token));
          } else if (provider == SocialAuthProviders.facebook) {
            return authFacebook(
                FacebookAuthParams(osId: osId, token: token.token));
          } else if (provider == SocialAuthProviders.apple) {
            return authWithApple(
                AppleAuthParams(osId: osId, token: token.token));
          }
          return Future.value(Left(ServerFailure()));
        },
        provider,
      ),
    );
  }

  Stream<AuthState> _mapLinkedAuthToState(
      AuthLinkedTokenRecieved event) async* {
    yield state.loading();
    const provider = SocialAuthProviders.linkedin;
    final osId = await pushNotifications.getSubscriptionToken();
    yield state.copyWith(isSubmitting: false);
    yield* _mapSocialAuthBackendCallToState(() {
      return authLinkedIn(LinkedAuthParams(osId: osId, token: event.token));
    }, provider);
  }

  Stream<AuthState> _mapSocialAuthBackendCallToState(
    Future<Either<Failure, User>> Function() callback,
    SocialAuthProviders provider,
  ) async* {
    yield state.loading();

    final response = await callback();
    yield* response.fold(
      (failure) async* {
        yield AuthRequestFailure(error: failure);
      },
      (user) async* {
        saveProvider(provider.toString());
        analytics.initSdk();
        analytics.identify(properties: getUserTraitsFromModel(user));
        analytics.trackEvent(
          eventName: AnalyticsEvents.authSocial,
          properties: {
            "email": user.email,
            "intent": user.intent,
            "provider": provider.toString(),
          },
        );

        final profileOrError = await getUserProfile(NoParams());
        yield profileOrError.fold(
          (failure) => AuthStateSuccess(
            user: user,
            profile: state.profile,
          ),
          (profile) => AuthStateSuccess(
            user: user,
            profile: profile,
          ),
        );
      },
    );
  }

  Future<void> saveProvider(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('AuthProvider', value);
  }

  Stream<AuthState> _mapLoginEmailToState(AuthLoginEmailPressed event) async* {
    if (state.isFormValid) {
      yield state.loading();
      final osId = await pushNotifications.getSubscriptionToken();
      final userOrFailure = await loginEmail(EmailLoginParams(
        email: event.email,
        password: event.password,
        osId: osId,
      ));

      final profileOrError = await getUserProfile(NoParams());
      final profile = profileOrError.getOrElse(() => state.profile!);

      yield userOrFailure.fold(
        (failure) => AuthRequestFailure(error: failure),
        (user) {
          analytics.initSdk();
          analytics.identify(properties: getUserTraitsFromModel(user));
          analytics.trackEvent(
            eventName: AnalyticsEvents.signInemail,
            properties: {
              "email": user.email,
              "intent": user.intent,
            },
          );

          return AuthStateSuccess(
            user: user,
            profile: profile,
          );
        },
      );
    }
  }

  Stream<AuthState> _mapRegisterEmailToState(
      AuthRegisterEmailPressed event) async* {
    if (state.isFormValid) {
      yield state.loading();
      final osId = await pushNotifications.getSubscriptionToken();
      final registerOrFailure = await registerEmail(RegisterEmailParams(
        email: event.email,
        password: event.password,
        name: event.name,
        osId: osId,
      ));

      yield registerOrFailure.fold(
        (failure) => AuthRequestFailure(error: failure),
        (user) {
          analytics.initSdk();
          analytics.identify(properties: getUserTraitsFromModel(user));
          analytics.trackEvent(
            eventName: AnalyticsEvents.signUpEmail,
            properties: {
              "email": user.email,
              "intent": user.intent,
            },
          );

          return AuthStateSuccess(
            user: user,
            profile: state.profile,
          );
        },
      );
    }
  }
}

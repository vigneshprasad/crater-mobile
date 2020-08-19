// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configureAuthFeature() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => AuthBloc(
        persistedUser: c<UCGetPersistedUser>(),
        authLinkedIn: c<UCAuthLinkedIn>(),
        authGoogle: c<UCGoogleAuth>(),
        loginEmail: c<UCLoginEmail>(),
        socialAuthToken: c<UCGetSocialAuthToken>()));
    container.registerFactory<AuthApiService>((c) => AuthApiServiceImpl());
    container.registerSingleton<AuthRepository>((c) => AuthRepositoryImpl(
        c<AuthRemoteDataSource>(), c<AuthLocalDataSource>()));
    container.registerSingleton<AuthRemoteDataSource>(
        (c) => AuthRemoteDataSourceImpl(c<AuthApiService>()));
    container.registerSingleton<AuthLocalDataSource>(
        (c) => AuthLocalDataSourceImpl());
    container.registerSingleton(
        (c) => UCGetPersistedUser(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCGoogleAuth(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCLoginEmail(repository: c<AuthRepository>()));
    container.registerSingleton(
        (c) => UCAuthLinkedIn(repository: c<AuthRepository>()));
  }

  void configureSocialAuthFeature() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton(
        (c) => UCGetSocialAuthToken(repository: c<SocialAuthRepository>()));
    container.registerSingleton<SocialAuthRepository>(
        (c) => SocialAuthRepositoryImpl(c<SocialAuthRemoteDataSource>()));
    container.registerSingleton<SocialAuthRemoteDataSource>(
        (c) => SocialAuthRemoteDataSourceImpl(googleSignIn: c<GoogleSignIn>()));
  }
}

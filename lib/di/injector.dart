import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiwi/kiwi.dart';

import '../api/auth/auth_api_service.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecase/get_persisted_user_usercase.dart';
import '../features/auth/domain/usecase/google_auth_usecase.dart';
import '../features/auth/domain/usecase/linked_auth_usecase.dart';
import '../features/auth/domain/usecase/login_email_usercase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/social_auth/data/datasources/social_auth_remote_datasource.dart';
import '../features/social_auth/data/repository/social_auth_repository_impl.dart';
import '../features/social_auth/domain/repository/social_auth_repository.dart';
import '../features/social_auth/domain/usecase/get_social_auth_token.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(AuthBloc)
  @Register.factory(AuthApiService, from: AuthApiServiceImpl)
  @Register.singleton(AuthRepository, from: AuthRepositoryImpl)
  @Register.singleton(AuthRemoteDataSource, from: AuthRemoteDataSourceImpl)
  @Register.singleton(AuthLocalDataSource, from: AuthLocalDataSourceImpl)
  @Register.singleton(UCGetPersistedUser)
  @Register.singleton(UCGoogleAuth)
  @Register.singleton(UCLoginEmail)
  @Register.singleton(UCAuthLinkedIn)
  void configureAuthFeature();

  @Register.singleton(UCGetSocialAuthToken)
  @Register.singleton(SocialAuthRepository, from: SocialAuthRepositoryImpl)
  @Register.singleton(SocialAuthRemoteDataSource,
      from: SocialAuthRemoteDataSourceImpl)
  void configureSocialAuthFeature();

  void configureInstances(KiwiContainer container) {
    container.registerInstance(GoogleSignIn(
      scopes: const [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    ));
  }
}

class Di {
  static void setup() {
    final container = KiwiContainer();
    final injector = _$Injector();

    injector.configureInstances(container);

    // Auth
    injector.configureAuthFeature();

    // Social Auth
    injector.configureSocialAuthFeature();
  }
}

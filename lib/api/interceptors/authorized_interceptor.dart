import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:kiwi/kiwi.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';

class AuthorizedInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final user =
        KiwiContainer().resolve<AuthLocalDataSource>().getUserFromCache();
    final token = user.token;
    if (token != null) {
      final authHeader = {HttpHeaders.authorizationHeader: 'JWT $token'};
      final requestWithAuth =
          request.copyWith(headers: {...request.headers, ...authHeader});

      return requestWithAuth;
    }
    return request;
  }
}

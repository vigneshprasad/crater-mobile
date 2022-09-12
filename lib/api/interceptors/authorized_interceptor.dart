import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';

final authInterceptorProvider = Provider(
  (ref) {
    return AuthorizedInterceptor(ref.read);
  },
);

class AuthorizedInterceptor extends RequestInterceptor {
  final Reader read;

  AuthorizedInterceptor(this.read);
  @override
  FutureOr<Request> onRequest(Request request) async {
    try {
      final token = read(authTokenProvider);
      if (token != null) {
        final authHeader = {HttpHeaders.authorizationHeader: 'JWT $token'};
        final requestWithAuth =
            request.copyWith(headers: {...request.headers, ...authHeader});
        return requestWithAuth;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return request;
  }
}

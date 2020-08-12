import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/constants/shared_pref_keys.dart';

class AuthorizedInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get(SharedPrefKeys.authToken);
    if (token != null) {
      final authHeader = {HttpHeaders.authorizationHeader: 'JWT $token'};
      final requestWithAuth =
          request.copyWith(headers: {...request.headers, ...authHeader});

      return requestWithAuth;
    }
    return request;
  }
}

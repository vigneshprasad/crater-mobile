import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';

final phoneStateProvider = StateProvider((ref) => '');

final phoneAPIProvider =
    StateNotifierProvider<PhoneAPINotifier, ApiResult<bool>>(
  (ref) => PhoneAPINotifier(ref.read),
);

class PhoneAPINotifier extends StateNotifier<ApiResult<bool>> {
  Reader read;
  PhoneAPINotifier(this.read) : super(ApiResult.data(false));

  Future<bool> submit() async {
    state = ApiResult.loading();

    final phone = read(phoneStateProvider);
    final response = await read(authRepositoryProvider).sendOtp(phone);

    return response.fold((failure) {
      final exception = failure.message as ServerException?;
      final errorDetail = exception?.message as String?;
      Map? map;
      try {
        map = jsonDecode(errorDetail ?? '') as Map?;
      } catch (e) {
        debugPrint(e.toString());
      }
      final message = (map?['error_message'] as String?) ??
          ((map?['username'] as List?)?.first as String?) ??
          failure.toString();
      final error = ServerFailure(message);
      state = ApiResult.error(error);
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 14,
      );
      return false;
    }, (r) {
      state = ApiResult.data(true);
      return true;
    });
  }
}

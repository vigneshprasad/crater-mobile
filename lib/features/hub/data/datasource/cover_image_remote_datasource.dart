import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/hub/cover_image_api_service.dart';

import '../../../../core/error/exceptions.dart';

final coverImageRemoteDatasourceProvider = Provider<CoverImageRemoteDatasource>(
    (_) => CoverImageRemoteDatasourceImpl(_.read));

abstract class CoverImageRemoteDatasource {
  /// Post Opt-in for Group Meeting to Remote Server
  /// Throws [ServerException]
  Future<String> postGenerateImageToRemote(
    String topic,
    String avtarUrl,
  );
}

class CoverImageRemoteDatasourceImpl implements CoverImageRemoteDatasource {
  final Reader read;

  CoverImageRemoteDatasourceImpl(this.read);

  @override
  Future<String> postGenerateImageToRemote(
    String topic,
    String avtarUrl,
  ) async {
    final body = {
      "topic": topic,
      "avtar_url": avtarUrl,
    };
    final response =
        await read(coverImageApiServiceProvider).generateImage(body);
    if (response.statusCode == 200) {
      final string = response.bodyString;
      return string;
    } else {
      throw ServerException(response.error);
    }
  }
}

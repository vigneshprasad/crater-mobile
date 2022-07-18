import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/conversations/data/models/conversation_failures/conversation_failures.dart';
import 'package:worknetwork/features/hub/data/datasource/cover_image_remote_datasource.dart';

final coverImageRepositoryProvider =
    Provider<CoverImageRepository>((ref) => CoverImageRepositoryImpl(ref.read));

abstract class CoverImageRepository {
  Future<Either<Failure, String>> postGenerateImage(
    String topic,
    String avtarUrl,
  );
}

class CoverImageRepositoryImpl implements CoverImageRepository {
  final Reader read;

  CoverImageRepositoryImpl(this.read);

  @override
  Future<Either<Failure, String>> postGenerateImage(
    String topic,
    String avtarUrl,
  ) async {
    try {
      final response = await read(coverImageRemoteDatasourceProvider)
          .postGenerateImageToRemote(topic, avtarUrl);
      return Right(response);
    } on ServerException catch (error) {
      final message =
          jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ConversationFailure.fromJson(message);
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }
}

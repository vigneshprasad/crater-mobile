import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/post_entity.dart';
import '../repository/community_repository.dart';

class UCCreatePost implements AsyncUseCase<Post, CreatePostParams> {
  final CommunityRepository repository;

  UCCreatePost(this.repository);

  @override
  Future<Either<Failure, Post>> call(CreatePostParams params) {
    return repository.createPost(params.message, params.images);
  }
}

class CreatePostParams extends Equatable {
  final String message;
  final List<File> images;

  const CreatePostParams({
    @required this.message,
    this.images,
  });

  @override
  List<Object> get props => [message, images];
}

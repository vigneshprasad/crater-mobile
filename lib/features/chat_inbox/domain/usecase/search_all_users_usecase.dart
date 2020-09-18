import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/chat_inbox_repository.dart';

class UCSearchAllUsers implements AsyncUseCase<void, SearchAllUsersParams> {
  final ChatInboxRepository repository;

  UCSearchAllUsers({
    @required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(SearchAllUsersParams params) {
    return repository.sendSearchAllChatUsers(
        params.search, params.filter, params.page, params.latestMessage);
  }
}

class SearchAllUsersParams extends Equatable {
  final String search;
  final int page;
  final bool strict;
  final String filter;
  final String latestMessage;

  const SearchAllUsersParams({
    this.latestMessage = "all",
    @required this.search,
    this.page = 1,
    this.strict = true,
    this.filter = "all",
  });

  @override
  List<Object> get props => [
        search,
        page,
        strict,
        filter,
      ];
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meeting_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetMeetings implements AsyncUseCase<List<Meeting>, NoParams> {
  final MeetingRepository repository;

  UCGetMeetings({
    @required this.repository,
  });

  @override
  Future<Either<Failure, List<Meeting>>> call(NoParams params) {
    return repository.getMeetings();
  }
}

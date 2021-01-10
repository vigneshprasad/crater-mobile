import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/reschedule_request_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetRescheduleRequest
    implements AsyncUseCase<RescheduleRequest, GetRescheduleRequestParams> {
  final MeetingRepository repository;

  UCGetRescheduleRequest(this.repository);

  @override
  Future<Either<Failure, RescheduleRequest>> call(
      GetRescheduleRequestParams params) {
    return repository.getRescheduleRequest(params.meetingId);
  }
}

class GetRescheduleRequestParams extends Equatable {
  final int meetingId;

  const GetRescheduleRequestParams({
    @required this.meetingId,
  });

  @override
  List<Object> get props => [meetingId];
}

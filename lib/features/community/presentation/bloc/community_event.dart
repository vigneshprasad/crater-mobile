part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object> get props => [];
}

class GetCommunityPageRequestStarted extends CommunityEvent {
  final int page;
  final int pageSize;

  const GetCommunityPageRequestStarted({
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [page, pageSize];
}

class DeletePostRequestStarted extends CommunityEvent {
  final int postId;

  const DeletePostRequestStarted({
    @required this.postId,
  });

  @override
  List<Object> get props => [postId];
}

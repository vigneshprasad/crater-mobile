part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  final dynamic error;
  final bool loading;
  const CommunityState({
    @required this.loading,
    @required this.error,
  });

  @override
  List<Object> get props => [error, loading];
}

class CommunityInitial extends CommunityState {
  const CommunityInitial()
      : super(
          loading: false,
          error: null,
        );
}

class CommunityRequestLoading extends CommunityState {
  const CommunityRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class CommunityRequestError extends CommunityState {
  const CommunityRequestError({
    @required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}

class CommunityGetPageResponseReceived extends CommunityState {
  final bool fromCache;
  final int pages;
  final int currentPage;
  final List<Post> posts;
  final int count;

  const CommunityGetPageResponseReceived({
    @required this.fromCache,
    @required this.pages,
    @required this.currentPage,
    @required this.posts,
    @required this.count,
  }) : super(loading: false, error: null);

  @override
  List<Object> get props => [
        error,
        loading,
        pages,
        currentPage,
        posts,
        fromCache,
        count,
      ];
}

class CommunityPostDeletedSuccess extends CommunityState {
  final int postId;

  const CommunityPostDeletedSuccess({
    this.postId,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        error,
        loading,
        postId,
      ];
}

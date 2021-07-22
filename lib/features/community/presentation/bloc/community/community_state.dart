part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  final Object? error;
  final bool loading;
  const CommunityState({
    required this.loading,
    required this.error,
  });

  @override
  List<Object> get props => error != null ? [error!, loading] : [loading];
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
    required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}

class CommunityGetPageResponseReceived extends CommunityState {
  final bool fromCache;
  final int? pages;
  final int? currentPage;
  final List<Post>? posts;
  final int? count;

  const CommunityGetPageResponseReceived({
    required this.fromCache,
    this.pages,
    this.currentPage,
    this.posts,
    this.count,
  }) : super(loading: false, error: null);

  @override
  List<Object> get props {
    final List<Object> temp = [
      loading,
      fromCache,
    ];

    if (pages != null) temp.add(pages!);
    if (currentPage != null) temp.add(currentPage!);
    if (posts != null) temp.add(posts!);
    if (count != null) temp.add(count!);

    return temp;
  }
}

class CommunityPostDeletedSuccess extends CommunityState {
  final int postId;

  const CommunityPostDeletedSuccess({
    required this.postId,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => error != null
      ? [
          error!,
          loading,
          postId,
        ]
      : [
          loading,
          postId,
        ];
}

class CommunityCreateLikeReceivedSuccess extends CommunityState {
  final Like like;

  const CommunityCreateLikeReceivedSuccess({
    required this.like,
  }) : super(
          loading: false,
          error: null,
        );
}

class CommunityDeleteLikeReceivedSuccess extends CommunityState {
  final Like like;

  const CommunityDeleteLikeReceivedSuccess({
    required this.like,
  }) : super(
          loading: false,
          error: null,
        );
}

class CommunityNewPostLoaded extends CommunityState {
  final Post post;

  const CommunityNewPostLoaded({
    required this.post,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => error != null
      ? [
          error!,
          loading,
          post,
        ]
      : [
          loading,
          post,
        ];
}

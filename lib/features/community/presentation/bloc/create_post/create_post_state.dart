part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  final bool loading;
  final Object? error;

  const CreatePostState({
    required this.loading,
    this.error,
  });

  @override
  List<Object> get props => error != null
      ? [
          loading,
          error!,
        ]
      : [loading];
}

class CreatePostInitial extends CreatePostState {
  const CreatePostInitial()
      : super(
          loading: false,
          error: null,
        );
}

class CreatePostRequestLoading extends CreatePostState {
  const CreatePostRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class CreatePostRequestError extends CreatePostState {
  const CreatePostRequestError({
    required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}

class CreatPostRequestSuccessLoaded extends CreatePostState {
  final Post post;
  const CreatPostRequestSuccessLoaded({
    required this.post,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => error != null
      ? [
          loading,
          error!,
          post,
        ]
      : [
          loading,
          post,
        ];
}

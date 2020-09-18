part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  final bool loading;
  final dynamic error;

  const CreatePostState({
    this.loading,
    this.error,
  });

  @override
  List<Object> get props => [
        loading,
        error,
      ];
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
    @required dynamic error,
  }) : super(
          loading: false,
          error: error,
        );
}

class CreatPostRequestSuccessLoaded extends CreatePostState {
  final Post post;
  const CreatPostRequestSuccessLoaded({
    this.post,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        loading,
        error,
        post,
      ];
}

part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostGetStarted extends PostEvent {
  @override
  List<Object> get props => [];
}

class PostGetError extends PostEvent {
  @override
  List<Object> get props => [];
}

class PostDeleteStarted extends PostEvent {
  final int id;

  const PostDeleteStarted(this.id);

  @override
  List<Object> get props => [id];
}

class PostDeleteSucess extends PostEvent {
  @override
  List<Object> get props => [];
}

class PostDeleteError extends PostEvent {
  @override
  List<Object> get props => [];
}

class PostCreateStarted extends PostEvent {
  final String message;
  final List<MultipartFile> files;

  const PostCreateStarted({
    @required this.message,
    this.files,
  });

  @override
  List<Object> get props => [message, files];
}

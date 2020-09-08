part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class CreatePostRequestStarted extends CreatePostEvent {
  final String message;
  final List<File> images;

  const CreatePostRequestStarted({
    this.message,
    this.images,
  });

  @override
  List<Object> get props => [message, images];
}

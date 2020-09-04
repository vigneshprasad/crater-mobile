part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  final bool loading;
  final dynamic error;

  const CommentState({
    this.loading,
    this.error,
  });

  @override
  List<Object> get props => [loading, error];
}

class CommentInitial extends CommentState {
  const CommentInitial() : super(loading: false, error: null);
}

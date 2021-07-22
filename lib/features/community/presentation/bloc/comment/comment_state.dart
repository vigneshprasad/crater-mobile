part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  final bool loading;
  final Object? error;

  const CommentState({
    required this.loading,
    this.error,
  });

  @override
  List<Object> get props => error != null ? [loading, error!] : [loading];
}

class CommentInitial extends CommentState {
  const CommentInitial() : super(loading: false, error: null);
}

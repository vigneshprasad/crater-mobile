import 'package:equatable/equatable.dart';

class PageSocketResponse<T> extends Equatable {
  final int page;
  final int pages;
  final List<T> results;
  final bool fromCache;

  const PageSocketResponse({
    required this.page,
    required this.pages,
    required this.results,
    required this.fromCache,
  });

  @override
  List<Object> get props => [
        page,
        pages,
        results,
        fromCache,
      ];
}

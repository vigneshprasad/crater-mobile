import 'package:equatable/equatable.dart';

class PageApiResponse<T> extends Equatable {
  final int? pageSize;
  final bool fromCache;
  final int? count;
  final int? currentPage;
  final int? pages;
  final List<T>? results;

  const PageApiResponse({
    this.pageSize,
    this.pages,
    required this.fromCache,
    this.count,
    this.currentPage,
    this.results,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [
      fromCache,
    ];

    if (pageSize != null) temp.add(pageSize!);
    if (count != null) temp.add(count!);
    if (currentPage != null) temp.add(currentPage!);
    if (results != null) temp.add(results!);
    if (pages != null) temp.add(pages!);
    return temp;
  }
}

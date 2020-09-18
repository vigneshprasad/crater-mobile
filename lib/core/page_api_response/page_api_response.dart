import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PageApiResponse<T> extends Equatable {
  final int pageSize;
  final bool fromCache;
  final int count;
  final int currentPage;
  final int pages;
  final List<T> results;

  const PageApiResponse({
    this.pageSize,
    this.pages,
    @required this.fromCache,
    @required this.count,
    @required this.currentPage,
    @required this.results,
  });

  @override
  List<Object> get props => [
        pageSize,
        fromCache,
        count,
        currentPage,
        pages,
        results,
      ];
}

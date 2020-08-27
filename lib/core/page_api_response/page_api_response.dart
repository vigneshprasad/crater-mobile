import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PageApiResponse<T> extends Equatable {
  final bool fromCache;
  final int count;
  final int currentPage;
  final int pages;
  final List<T> results;

  const PageApiResponse({
    @required this.fromCache,
    @required this.count,
    @required this.currentPage,
    @required this.pages,
    @required this.results,
  });

  @override
  List<Object> get props => [
        fromCache,
        count,
        currentPage,
        pages,
        results,
      ];
}

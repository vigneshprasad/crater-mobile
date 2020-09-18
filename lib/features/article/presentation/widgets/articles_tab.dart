import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/core/widgets/screens/models/home_screen_tab_model.dart';
import 'package:worknetwork/features/article/domain/entity/article_entity.dart';
import 'package:worknetwork/ui/components/article_card/article_card.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../core/widgets/layouts/home_tab_layout.dart';
import '../bloc/article_bloc.dart';

class ArticlesTab extends HomeScreenTab {
  @override
  _ArticlesTabState createState() => _ArticlesTabState();

  @override
  double get expandedHeight => 116;

  @override
  String get headingKey => "articles:title";

  @override
  String get subheadingKey => "articles:subtitle";
}

class _ArticlesTabState extends State<ArticlesTab> {
  int _pages;
  int _currentPage;
  ArticleBloc _bloc;
  List<Article> _articles;
  Completer<void> _completer;
  final _pageSize = 10;

  @override
  void initState() {
    _completer = Completer<void>();
    _pages = 1;
    _currentPage = 1;
    _bloc = BlocProvider.of<ArticleBloc>(context)
      ..add(ArticlesGetPageRequestStarted(
        page: _currentPage,
        pageSize: _pageSize,
      ));
    _articles = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: _blocListener,
      builder: (context, state) {
        return HomeTabLayout(
          onRefresh: _onRefreshArticles,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                _buildArticlesList,
                childCount: _articles.length,
              ),
            )
          ],
        );
      },
    );
  }

  void _blocListener(BuildContext context, ArticleState state) {
    if (state is ArticlesPageRequestLoaded) {
      _completer.complete();
      _completer = Completer<void>();
      setState(() {
        _pages = state.pages;
        _articles = [..._articles, ...state.articles];
        _currentPage = state.currentPage;
      });
    }
  }

  Widget _buildArticlesList(BuildContext context, int index) {
    final article = _articles[index];
    return ArticleCard(article: article);
  }

  Future<void> _onRefreshArticles() {
    setState(() {
      _articles = [];
      _pages = 1;
      _currentPage = 1;
      _bloc.add(ArticlesGetPageRequestStarted(
        page: _currentPage,
        pageSize: _pageSize,
      ));
    });
    return _completer.future;
  }
}

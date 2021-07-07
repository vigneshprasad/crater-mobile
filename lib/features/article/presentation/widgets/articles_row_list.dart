import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/theme.dart';
import '../../domain/entity/article_entity.dart';
import '../bloc/article_bloc.dart';
import 'article_card.dart';

class ArticlesRowList extends StatefulWidget {
  final int websiteTagId;

  const ArticlesRowList({
    Key key,
    @required this.websiteTagId,
  }) : super(key: key);

  @override
  _ArticlesRowListState createState() => _ArticlesRowListState();
}

class _ArticlesRowListState extends State<ArticlesRowList> {
  final _pageSize = 10;
  int _pages;
  int _currentPage;
  List<Article> _articles;
  ArticleBloc _bloc;
  bool _fromCache;

  @override
  void initState() {
    _articles = [];
    _fromCache = false;
    _currentPage = 1;
    _bloc = BlocProvider.of<ArticleBloc>(context)
      ..add(ArticlesGetPageRequestStarted(
        page: _currentPage,
        pageSize: _pageSize,
        websiteTag: widget.websiteTagId,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: _blocListener,
      builder: (context, state) {
        return SizedBox(
          height: 200,
          child: state.loading ? _buildShimmerLayout() : _buildArticlesList(),
        );
      },
    );
  }

  Widget _buildArticlesList() {
    return ListView.builder(
      padding: const EdgeInsets.only(left: AppInsets.l),
      scrollDirection: Axis.horizontal,
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        return ArticleCard(article: _articles[index]);
      },
    );
  }

  Widget _buildShimmerLayout() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[200],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: AppInsets.l),
        itemCount: 4,
        itemBuilder: (context, index) => Card(
          color: Colors.white,
          child: Container(
            width: 180,
          ),
        ),
      ),
    );
  }

  void _blocListener(BuildContext context, ArticleState state) {
    if (state is ArticlesPageRequestLoaded &&
        state.websiteTag == widget.websiteTagId) {
      setState(() {
        _currentPage = state.currentPage;
        _fromCache = state.fromCache;
        _articles = [..._articles, ...state.articles];
        _pages = state.pages;
      });
    }
  }
}

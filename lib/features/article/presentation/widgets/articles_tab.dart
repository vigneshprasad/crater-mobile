import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/screens/models/home_screen_tab_model.dart';
import 'package:worknetwork/features/article/domain/entity/article_entity.dart';
import 'package:worknetwork/features/article/domain/entity/article_website_entity.dart';
import 'package:worknetwork/features/article/presentation/widgets/articles_row_list.dart';
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
  ArticleBloc _bloc;
  List<ArticleWebsite> _websites;
  Completer<void> _completer;

  @override
  void initState() {
    _completer = Completer<void>();
    _websites = [];
    _bloc = BlocProvider.of<ArticleBloc>(context)
      ..add(const GetArticleWebsitesRequestStarted());
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
            ..._buildArticlesRows(context),
          ],
        );
      },
    );
  }

  void _blocListener(BuildContext context, ArticleState state) {
    if (state is ArticleWebsitesRequestLoaded) {
      _completer.complete();
      _completer = Completer<void>();
      setState(() {
        _websites = state.websites;
      });
    }
  }

  Future<void> _onRefreshArticles() {
    setState(() {
      _websites = [];
    });
    _bloc.add(const GetArticleWebsitesRequestStarted());
    return _completer.future;
  }

  List<Widget> _buildArticlesRows(BuildContext context) {
    return _websites.fold([], (previousValue, website) {
      final headingStyle = Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          );
      final heading = SliverPadding(
        padding: const EdgeInsets.symmetric(
            vertical: AppInsets.l, horizontal: AppInsets.xxl),
        sliver: SliverToBoxAdapter(
          child: Text(website.name, style: headingStyle),
        ),
      );

      final list = SliverToBoxAdapter(
        child: ArticlesRowList(
          websiteTagId: website.pk,
        ),
      );

      previousValue.add(heading);
      previousValue.add(list);
      return previousValue;
    });
  }
}

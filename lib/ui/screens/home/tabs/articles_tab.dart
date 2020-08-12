import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/article/bloc/article_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/models/article/article_model.dart';
import 'package:worknetwork/ui/base/base_icon_button/base_icon_button.dart';
import 'package:worknetwork/ui/base/tab_header/tab_header.dart';
import 'package:worknetwork/ui/components/article_card/article_card.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class ArticlesTab extends StatefulWidget {
  @override
  _ArticlesTabState createState() => _ArticlesTabState();
}

class _ArticlesTabState extends State<ArticlesTab> {
  List<Article> _articles = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        AppLocalizations.of(context).translate("articles:title");
    final String subtitle =
        AppLocalizations.of(context).translate("articles:subtitle");
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: _articleBlocListener,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: AppInsets.xl,
                right: AppInsets.med,
              ),
              child: TabHeader(
                heading: title,
                subHeading: subtitle,
                action: BaseIconButton(
                  icon: const Icon(WorkNetIcons.filters),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_loading) const LinearProgressIndicator(),
            Expanded(
              child: _buildArticlesList(),
            )
          ],
        );
      },
    );
  }

  void _articleBlocListener(BuildContext context, ArticleState state) {
    if (state is ArticleGetLoading) {
      setState(() => _loading = true);
    } else {
      setState(() => _loading = false);
    }

    if (state is ArticleGetSuccess) {
      setState(() {
        _articles = state.response.results;
      });
    }
  }

  Widget _buildArticlesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.med, vertical: AppInsets.med),
      itemCount: _articles.length,
      itemBuilder: _buildArticleItem,
    );
  }

  Widget _buildArticleItem(BuildContext context, int index) {
    final article = _articles[index];
    return ArticleCard(article: article);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/post/bloc/post_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/models/post/post_model.dart';
import 'package:worknetwork/ui/base/base_icon_button/base_icon_button.dart';
import 'package:worknetwork/ui/base/tab_header/tab_header.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class CommunityTab extends StatefulWidget {
  @override
  _CommunityTabState createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
  PostBloc _postBloc;
  Completer<void> _refreshCompleter;
  List<PostModel> _posts = [];

  @override
  void initState() {
    _postBloc = BlocProvider.of<PostBloc>(context)
      ..add(
        PostGetStarted(),
      );
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        AppLocalizations.of(context).translate("community:title");
    final String subtitle =
        AppLocalizations.of(context).translate("community:subtitle");
    return Column(
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
        Expanded(
          child: _buildPostsList(),
        ),
      ],
    );
  }

  Widget _buildPostsList() {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostGetSuccess) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          _setPosts(state.posts);
        }
      },
      builder: (context, state) {
        if (state is PostGetSuccess && _posts.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () {
              _postBloc.add(PostGetStarted());
              return _refreshCompleter.future;
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.med,
                vertical: AppInsets.xl,
              ),
              itemCount: state.posts.length,
              itemBuilder: (BuildContext ctx, int index) {
                final post = _posts[index];
                return ListTile();
              },
            ),
          );
        }

        return Container();
      },
    );
  }

  void _setPosts(List<PostModel> posts) {
    setState(() {
      _posts = posts;
    });
  }

  void _onPostDelete(int id) {
    _postBloc.add(PostDeleteStarted(id));
  }
}

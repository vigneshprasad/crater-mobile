import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/layouts/home_tab_layout.dart';
import '../../../../ui/components/cards/masterclass_card/masterclass_card.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/video_entity.dart';
import '../bloc/video/video_bloc.dart';

class VideoTab extends StatefulWidget {
  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  bool _fromCache;
  int _currentPage;
  int _pages;
  List<Video> _videos;
  Completer<void> _completer;
  VideoBloc _bloc;
  final _pageSize = 10;

  @override
  void initState() {
    _fromCache = false;
    _currentPage = 1;
    _videos = [];
    _pages = 1;
    _completer = Completer<void>();
    _bloc = BlocProvider.of<VideoBloc>(context)
      ..add(
          GetVideosListRequestStarted(page: _currentPage, pageSize: _pageSize));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String heading =
        AppLocalizations.of(context).translate('videos:title');
    final String subHeading =
        AppLocalizations.of(context).translate('videos:subtitle');
    return BlocConsumer<VideoBloc, VideoState>(
      listener: _blocListener,
      builder: (context, state) {
        return HomeTabLayout(
          heading: heading,
          subHeading: subHeading,
          onRefresh: _onRefreshList,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.med, vertical: AppInsets.l),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  _buildVideoListItem,
                  childCount: _videos.length,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _blocListener(BuildContext context, VideoState state) {
    if (state is VideoPageResponseLoaded) {
      _completer?.complete();
      _completer = Completer<void>();
      setState(() {
        _currentPage = state.currentPage;
        _fromCache = state.fromCache;
        _pages = state.pages;
        _videos = [..._videos, ...state.videos];
      });
    }
  }

  Widget _buildVideoListItem(BuildContext context, int index) {
    final video = _videos[index];
    return MasterclassCard(item: video);
  }

  Future<void> _onRefreshList() {
    setState(() {
      _currentPage = 1;
      _videos = [];
    });
    _bloc.add(
        GetVideosListRequestStarted(page: _currentPage, pageSize: _pageSize));
    return _completer.future;
  }
}

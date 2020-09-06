import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/layouts/home_tab_layout.dart';
import 'package:worknetwork/features/videos/domain/entity/video_entity.dart';
import 'package:worknetwork/features/videos/presentation/bloc/video/video_bloc.dart';

import '../../../../ui/components/cards/masterclass_card/masterclass_card.dart';
import '../../../../utils/app_localizations.dart';

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
    final String title = AppLocalizations.of(context).translate("videos:title");
    final String subtitle =
        AppLocalizations.of(context).translate("videos:subtitle");
    // return BlocBuilder<VideoBloc, VideoState>(
    //   builder: (context, state) {
    //     return Column(
    //       children: <Widget>[
    //         Padding(
    //           padding: const EdgeInsets.only(
    //             left: AppInsets.xl,
    //             right: AppInsets.med,
    //           ),
    //           child: TabHeader(
    //             heading: title,
    //             subHeading: subtitle,
    //             action: BaseIconButton(
    //               icon: const Icon(WorkNetIcons.filters),
    //               onPressed: () {
    //                 showModalBottomSheet(
    //                   context: context,
    //                   builder: (context) => Container(
    //                     color: Colors.white,
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           child: _buildVideoList(context, state),
    //         )
    //       ],
    //     );
    //   },
    // );
    return BlocConsumer<VideoBloc, VideoState>(
      listener: _blocListener,
      builder: (context, state) {
        return HomeTabLayout(
          onRefresh: _onRefreshList,
          heading: title,
          subheading: subtitle,
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

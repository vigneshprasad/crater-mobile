import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/features/videos/presentation/bloc/video/video_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../../../../ui/base/base_icon_button/base_icon_button.dart';
import '../../../../ui/base/tab_header/tab_header.dart';
import '../../../../ui/components/cards/masterclass_card/masterclass_card.dart';
import '../../../../utils/app_localizations.dart';

class VideoTab extends StatefulWidget {
  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  var _currentPage = 1;
  @override
  void initState() {
    BlocProvider.of<VideoBloc>(context)
        .add(GetVideosListRequestStarted(page: _currentPage));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate("videos:title");
    final String subtitle =
        AppLocalizations.of(context).translate("videos:subtitle");
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
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
              child: _buildVideoList(context, state),
            )
          ],
        );
      },
    );
  }

  Widget _buildVideoList(BuildContext context, VideoState state) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.med, horizontal: AppInsets.med),
      itemCount: state.videos.length,
      itemBuilder: (context, index) {
        return MasterclassCard(
          item: state.videos[index],
        );
      },
    );
  }
}

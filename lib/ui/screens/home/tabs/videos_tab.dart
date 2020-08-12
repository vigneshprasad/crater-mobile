import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/masterclass/bloc/masterclass_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/models/masterclass/masterclass_model.dart';
import 'package:worknetwork/ui/base/base_icon_button/base_icon_button.dart';
import 'package:worknetwork/ui/base/masterclass_card/masterclass_card.dart';
import 'package:worknetwork/ui/base/tab_header/tab_header.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class VideoTab extends StatefulWidget {
  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  List<MasterClass> _videos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate("videos:title");
    final String subtitle =
        AppLocalizations.of(context).translate("videos:subtitle");
    return BlocConsumer<MasterclassBloc, MasterclassState>(
      listener: _masterclassBlocListener,
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
              child: _buildVideoList(context),
            )
          ],
        );
      },
    );
  }

  Widget _buildVideoList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.med, horizontal: AppInsets.med),
      itemCount: _videos.length,
      itemBuilder: _buildVideoItem,
    );
  }

  Widget _buildVideoItem(BuildContext context, int index) {
    final video = _videos[index];
    return MasterclassCard(
      item: video,
    );
  }

  void _masterclassBlocListener(BuildContext context, MasterclassState state) {
    if (state is MasterclassGetSuccess) {
      setState(() {
        _videos = state.response.results;
      });
    }
  }
}

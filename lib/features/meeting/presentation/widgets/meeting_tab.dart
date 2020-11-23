import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/theme.dart';
import '../../../../core/analytics/analytics.dart';
import '../../../../core/widgets/base/base_tab_bar/base_tab_bar.dart';
import '../../../../core/widgets/layouts/tab_layouts/tab_with_tabbar_layout.dart';
import '../../../../routes.gr.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../bloc/meeting_bloc.dart';
import 'meeting_upcoming_tab.dart';
import 'meetings_past_tab.dart';
import 'register_meeting_button.dart';

class MeetingTab extends StatefulWidget {
  @override
  _MeetingTabState createState() => _MeetingTabState();
}

class _MeetingTabState extends State<MeetingTab>
    with
        AutomaticKeepAliveClientMixin<MeetingTab>,
        SingleTickerProviderStateMixin {
  final Analytics analytics = KiwiContainer().resolve<Analytics>();
  MeetingConfig config;
  UserMeetingPreference preference;
  List<Meeting> upcoming;
  List<Meeting> past;
  List<MeetingInterest> interests;
  List<MeetingObjective> objectives;
  TabController _tabController;

  final List<Widget> tabs = [
    const BaseTab(text: "Upcoming"),
    const BaseTab(text: "Past")
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    initializeData();
    _tabController = TabController(length: tabs.length, vsync: this);
    upcoming = [];
    past = [];
    objectives = [];
    interests = [];
    config = null;
    preference = null;
    super.initState();
  }

  void initializeData() {
    BlocProvider.of<MeetingBloc>(context)
      ..add(const GetMeetingPreferencesStarted())
      ..add(const GetMeetingConfigStarted())
      ..add(const GetMeetingStarted())
      ..add(const GetMeetingObjectivesStarted())
      ..add(const GetMeetingInterestsStarted());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final heading = AppLocalizations.of(context).translate("meeting:title");
    final subheading =
        AppLocalizations.of(context).translate("meeting:subtitle");

    return BlocConsumer<MeetingBloc, MeetingState>(
      listener: _blockListener,
      builder: (context, state) {
        return TabWithTabbarLayout(
          heading: heading,
          subheading: subheading,
          tabbar: BaseTabBar(
            controller: _tabController,
            tabs: tabs,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              TabBarView(
                controller: _tabController,
                children: [
                  MeetingUpcomingTab(
                    upcoming: upcoming,
                    config: config,
                    preference: preference,
                    onRefresh: _onRefreshTab,
                  ),
                  MeetingsPastTab(
                    past: past,
                    onRefresh: _onRefreshTab,
                  ),
                ],
              ),
              if (preference == null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: AppInsets.xxl),
                    child: RegisterMeetingButton(
                      label: "Opt In for Next Week",
                      onPressed: () {
                        ExtendedNavigator.of(context)
                            .push(
                              Routes.registerMeetingScreen,
                              arguments: RegisterMeetingScreenArguments(
                                config: config,
                                preference: preference,
                                objectives: objectives,
                                interests: interests,
                              ),
                            )
                            .then((value) => initializeData());
                      },
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  void _blockListener(BuildContext context, MeetingState state) {
    if (state is GetMeetingLoaded) {
      setState(() {
        upcoming = state.upcoming;
        past = state.past;
      });
    } else if (state is MeetingGetConfigLoaded) {
      setState(() {
        config = state.config;
      });
    } else if (state is MeetingGetPreferencesLoaded) {
      setState(() {
        preference = state.preference;
      });
    } else if (state is MeetingGetObjectivesLoaded) {
      setState(() {
        objectives = state.objectives;
      });
    } else if (state is MeetingGetInterestsLoaded) {
      setState(() {
        interests = state.interests;
      });
    }
  }

  void _onRefreshTab() {
    setState(() {
      upcoming = [];
      BlocProvider.of<MeetingBloc>(context).add(const GetMeetingStarted());
    });
  }
}

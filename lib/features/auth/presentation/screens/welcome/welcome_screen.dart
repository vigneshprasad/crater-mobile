import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../routes.gr.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _activeIndex;

  final List<Widget> _tabs = const [
    _ImageSlide(
      image: AppImageAssets.splashDiscover,
      heading: "00.\nDiscover & converse with relevant professionals",
      subheading:
          "Exchange knowledge, explore synergies, and advance your career & business by conversing with relevant professionals",
    ),
    _ImageSlide(
      image: AppImageAssets.splashTopic,
      heading: "01.\nPick a conversation topic",
      subheading:
          "Simply choose a topic that is relevant to\nyou or your business.",
    ),
    _ImageSlide(
      image: AppImageAssets.splashPeople,
      heading: "02.\nChoose whom to meet",
      subheading:
          "Simply choose the profession of the person you want to converse with",
    ),
    _ImageSlide(
      image: AppImageAssets.splashAI,
      heading: "03.\nOur AI goes to work",
      subheading:
          "Our AI engine with search for the best\npossible match for you ",
    ),
    _ImageSlide(
      image: AppImageAssets.splashConversation,
      heading: "04.\nYour conversation is set up",
      subheading:
          "You will be matched with 1 or more people\nfor the conversation ",
    ),
    _ImageSlide(
      image: AppImageAssets.splashVirtual,
      heading: "05.\nConverse virtually ",
      subheading: "All you have to do is join the meeting at\nthe meeting time",
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _activeIndex = _tabController.index;
    _tabController.addListener(_tabChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabChangeListener);
    _tabController.dispose();
    super.dispose();
  }

  void _tabChangeListener() {
    setState(() {
      _activeIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          TabBarView(
            controller: _tabController,
            children: _tabs,
          ),
          Positioned(
            bottom: 56,
            child: _buildViewContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildViewContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SlideIndicator(
            length: _tabs.length,
            activeIndex: _activeIndex,
          ),
          const SizedBox(height: AppInsets.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.4,
                child: RaisedButton(
                  color: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    _openSignupAuthScreen(false, context);
                  },
                  child: Text('Sign in'),
                ),
              ),
              const SizedBox(width: AppInsets.xl),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.4,
                child: RaisedButton(
                  onPressed: () {
                    _openSignupAuthScreen(true, context);
                  },
                  child: Text('Sign up'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openSignupAuthScreen(bool showSignup, BuildContext context) {
    final state = showSignup ? "signup" : "signin";
    ExtendedNavigator.of(context).popAndPush(Routes.authScreen(state: state));
  }
}

class _ImageSlide extends StatelessWidget {
  final ImageProvider image;
  final String heading;
  final String subheading;

  const _ImageSlide({
    Key key,
    @required this.image,
    @required this.heading,
    @required this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline4.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: Colors.grey[700],
        );
    final subheadingStyle = Theme.of(context).textTheme.headline4.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.grey[700],
        );
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          const EdgeInsets.only(top: 40.0, bottom: 160, left: 40, right: 40),
      child: Column(children: [
        const Spacer(),
        Image(
          image: image,
          fit: BoxFit.contain,
          height: 280,
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              textAlign: TextAlign.start,
              style: headingStyle,
            ),
            const SizedBox(height: AppInsets.med),
            Text(
              subheading,
              textAlign: TextAlign.start,
              style: subheadingStyle,
            ),
          ],
        )
      ]),
    );
  }
}

class _SlideIndicator extends StatelessWidget {
  final int length;
  final int activeIndex;

  const _SlideIndicator({
    Key key,
    @required this.length,
    @required this.activeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildIndicatorItems(context),
    );
  }

  List<Widget> _buildIndicatorItems(BuildContext context) {
    final list = List(length);
    final List<Widget> items = [];

    for (int index = 0; index < list.length; index++) {
      final primaryColor = Theme.of(context).primaryColor;
      final color = index == activeIndex ? primaryColor : Colors.grey[200];
      final isLast = index == length - 1;

      items.add(
        Padding(
          padding: isLast
              ? EdgeInsets.zero
              : const EdgeInsets.only(right: AppInsets.l),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      );
    }

    return items;
  }
}

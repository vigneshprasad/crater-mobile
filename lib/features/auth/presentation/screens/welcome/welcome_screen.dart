import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';

import '../../../../../routes.gr.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _activeIndex;
  List<String> textMap = [
    "Opt-in for Meeting",
    "Curated Matching",
    "Attend Meeting",
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
    final headingStyle = Theme.of(context).textTheme.headline4.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: Colors.white,
        );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _ImageSlide(image: AppImageAssets.drawerBg),
              _ImageSlide(image: AppImageAssets.drawerBg),
              _ImageSlide(image: AppImageAssets.drawerBg),
            ],
          ),
          Positioned(
            bottom: 56,
            child: _buildViewContent(context),
          ),
          Positioned(
            top: 72,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  textMap[_activeIndex],
                  textAlign: TextAlign.center,
                  style: headingStyle,
                ),
              ),
            ),
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
            length: 3,
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

  const _ImageSlide({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
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
      final color = index == activeIndex ? primaryColor : Colors.white;
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

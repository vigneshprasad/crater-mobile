import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_container/scaffold_container.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _activeIndex;

  final List<Widget> _tabs = const [
    _ImageSlide(
      image: AppImageAssets.splashLearn,
      heading: "A New Way to Learn",
      subheading:
          "Learn about design, crypto, stocks, marketing and a lot more on livestreams by experts!",
    ),
    _ImageSlide(
      image: AppImageAssets.splashChat,
      heading: "Chat and Interact",
      subheading:
          "Ask questions, chat with the creator and others on the stream - be part of the learning community",
    ),
    _ImageSlide(
      image: AppImageAssets.splashAuction,
      heading: "Take part in Auctions",
      subheading:
          "Place bids and get access to exclusive content by our livestreaming creators",
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
      body: ScaffoldContainer(
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              TabBarView(
                controller: _tabController,
                children: _tabs,
              ),
              Positioned(
                bottom: 20,
                child: _buildViewContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: BaseLargeButton(
                text: _activeIndex == _tabs.length - 1
                    ? 'Login and start exploring'
                    : 'Next',
                icon: Icons.arrow_forward,
                onPressed: () => openBottomSheet(context),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _SlideIndicator(
              length: _tabs.length,
              activeIndex: _activeIndex,
            ),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context, {bool isSignUp = true}) {
    if (_activeIndex < _tabs.length - 1) {
      _activeIndex += 1;
      _tabController.animateTo(_activeIndex);
      return;
    }

    AutoRouter.of(context).pushAndPopUntil(
      HomeScreenRoute(),
      predicate: (route) => false,
    );
  }
}

class _ImageSlide extends StatelessWidget {
  final ImageProvider image;
  final String heading;
  final String subheading;

  const _ImageSlide({
    Key? key,
    required this.image,
    required this.heading,
    required this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline5;
    final subheadingStyle = Theme.of(context).textTheme.bodyText2;
    return Container(
      padding: const EdgeInsets.only(bottom: 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Image(
            image: image,
            width: double.infinity,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              heading,
              style: headingStyle,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              subheading,
              style: subheadingStyle,
            ),
          )
        ],
      ),
    );
  }
}

class _SlideIndicator extends StatelessWidget {
  final int length;
  final int activeIndex;

  const _SlideIndicator({
    Key? key,
    required this.length,
    required this.activeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildIndicatorItems(context),
    );
  }

  List<Widget> _buildIndicatorItems(BuildContext context) {
    final List<Widget> items = [];

    for (int index = 0; index < length; index++) {
      final isActive = index == activeIndex;
      final color = isActive ? null : Colors.white24;
      final width = isActive ? 12.0 : 6.0;
      final isLast = index == length - 1;
      final border = isActive ? Border.all(color: Colors.white24) : null;

      items.add(
        Padding(
          padding: isLast
              ? EdgeInsets.zero
              : const EdgeInsets.only(right: AppInsets.l),
          child: Container(
            width: width,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              border: border,
            ),
          ),
        ),
      );
    }

    return items;
  }
}

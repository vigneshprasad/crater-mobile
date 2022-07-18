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
      image: AppImageAssets.splashDiscover,
      heading: "Welcome to Crater",
      subheading: "A live streaming & auctions platform for creators",
    ),
    _ImageSlide(
      image: AppImageAssets.splashTopic,
      heading: "Join Live Stream",
      subheading:
          "On Crater you can tune into live streams realted to stock trading, design & much more",
    ),
    _ImageSlide(
      image: AppImageAssets.splashPeople,
      heading: "Chat & Interact",
      subheading:
          "In the live streams interact with your favourite creators & ask all your questions",
    ),
    _ImageSlide(
      image: AppImageAssets.splashAI,
      heading: "View Past Stream",
      subheading:
          "Missed a stream? Not a problem. You can explore past streams as well.",
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
      height: 100,
      child: Column(
        children: [
          _SlideIndicator(
            length: _tabs.length,
            activeIndex: _activeIndex,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flexible(
                //   flex: 5,
                //   child: BaseLargeButton(
                //     text: 'Login',
                //     onPressed: () => openBottomSheet(context, isSignUp: false),
                //   ),
                // ),
                // Flexible(
                //   child: Container(),
                // ),
                Flexible(
                  flex: 5,
                  child: SizedBox(
                    width: 160,
                    child: BaseLargeButton(
                      text: _activeIndex == 3 ? 'Explore' : 'Next',
                      onPressed: () => openBottomSheet(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openBottomSheet(BuildContext context, {bool isSignUp = true}) {
    if (_activeIndex < _tabs.length - 1) {
      _activeIndex += 1;
      _tabController.animateTo(_activeIndex);
      return;
    }

    AutoRouter.of(context).navigate(HomeScreenRoute());
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
    final headingStyle = Theme.of(context).textTheme.headline4?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        );
    final subheadingStyle = Theme.of(context).textTheme.headline4?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
    return Container(
      padding: const EdgeInsets.only(bottom: 200),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              heading,
              style: headingStyle,
            ),
          ),
          const Spacer(),
          Image(
            image: image,
            width: double.infinity,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              subheading,
              textAlign: TextAlign.center,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildIndicatorItems(context),
    );
  }

  List<Widget> _buildIndicatorItems(BuildContext context) {
    final List<Widget> items = [];

    for (int index = 0; index < length; index++) {
      final primaryColor = Theme.of(context).primaryColor;
      final color = index == activeIndex ? primaryColor : Colors.white24;
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

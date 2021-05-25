import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/presentation/screens/onboarding/onboarding_screen_state.dart';
import 'package:worknetwork/routes.gr.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../bloc/auth_bloc.dart';
import 'models/onboarding_slide_content.dart';

const kHeaderFraction = 0.65;
const kbottomBarHeight = 72.00;

class OnboardingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    final slideContent = [
      OnboardingSlideContent(
        heading: "Hi ${user.name}",
        subHeading: "Your network is waiting for you.",
        image: AppImageAssets.onboardingHello,
      ),
      const OnboardingSlideContent(
        heading: "",
        subHeading: "You can meet people via 1-on-1 or group conversations",
        image: AppImageAssets.onboardinCall,
      ),
      const OnboardingSlideContent(
        heading: "",
        subHeading: "Start by picking a topic that interests you",
        image: AppImageAssets.splashTopic,
      ),
      const OnboardingSlideContent(
        heading: "",
        subHeading: "Pick whom you want to meet & at what time",
        image: AppImageAssets.splashPeople,
      ),
      const OnboardingSlideContent(
        heading: "",
        subHeading: "We will match you with like minded people",
        image: AppImageAssets.splashConversation,
      ),
      const OnboardingSlideContent(
        heading: "",
        subHeading: "All you have to do is join the conversation",
        image: AppImageAssets.splashDiscover,
      ),
      const OnboardingSlideContent(
        heading: "",
        subHeading:
            "You can also explore on-going conversations & drop in to converse",
        image: AppImageAssets.onboardingGroupCards,
      ),
      const OnboardingSlideContent(
        heading: "",
        subHeading: "What do you want to do first?",
        image: AppImageAssets.splashAI,
      ),
    ];

    final pageController = usePageController();
    final currentPage = useState(0.0);

    useEffect(() {
      void listener() {
        currentPage.value = pageController.page;
      }

      pageController.addListener(listener);

      return () {
        pageController.removeListener(listener);
      };
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _BaseLayout(),
            Container(
              padding: const EdgeInsets.only(bottom: kbottomBarHeight),
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) =>
                    _PageContent(content: slideContent[index]),
                itemCount: slideContent.length,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: kbottomBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildActionButtons(
                    context,
                    pageController,
                    currentPage,
                    currentPage.value == slideContent.length - 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons(
      BuildContext context,
      PageController controller,
      ValueNotifier<double> currentPage,
      bool isLast) {
    const duration = Duration(milliseconds: 200);

    if (currentPage.value == 0) {
      return [
        _ActionButton(
          label: "Get Started",
          onTap: () {
            controller.animateToPage(1,
                duration: duration, curve: Curves.easeInOut);
          },
        ),
      ];
    } else if (isLast) {
      return [
        _ActionButton(
          label: "Start a conversation",
          onTap: () {
            context.read(onboardingProvider).setOnboardingShown();
            ExtendedNavigator.of(context).popAndPush(Routes.homeScreen(tab: 0));
          },
        ),
        _ActionButton(
          label: "Join a conversation",
          onTap: () {
            context.read(onboardingProvider).setOnboardingShown();
            ExtendedNavigator.of(context).popAndPush(Routes.homeScreen(tab: 1));
          },
        ),
      ];
    } else {
      return [
        _ActionButton(
          label: "Next",
          onTap: () {
            controller.animateToPage(currentPage.value.floor() + 1,
                duration: duration, curve: Curves.easeInOut);
          },
        ),
      ];
    }
  }
}

class _BaseLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * kHeaderFraction,
          color: Colors.transparent,
        ),
        const Expanded(child: BaseContainer()),
      ],
    );
  }
}

class _PageContent extends StatelessWidget {
  final OnboardingSlideContent content;

  const _PageContent({
    Key key,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 18,
          color: Colors.white54,
        );
    final subheadStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 20,
        );
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * kHeaderFraction,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppInsets.xxl),
              child: Image(image: content.image),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.xxl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  content.heading,
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  content.subHeading,
                  style: subheadStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    Key key,
    @required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BaseContainer(
        radius: 18.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppInsets.l,
            horizontal: AppInsets.xl,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

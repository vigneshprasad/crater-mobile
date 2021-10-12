import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/features/share_manager/share_manager.dart';
import '../../bloc/auth_bloc.dart';
import 'models/onboarding_slide_content.dart';
import 'onboarding_screen_state.dart';

const kHeaderFraction = 0.65;
const kbottomBarHeight = 72.00;

enum OnboardingType {
  signupComplete,
  oneOnOneMeetingCreation,
  groupMeetingCreation,
  meetingJoining,
  meetingLeaving,
}

class OnboardingScreen extends HookWidget {
  final String type;

  const OnboardingScreen(@PathParam('type') this.type);

  OnboardingType typeFromString(String str) {
    switch (str.replaceFirst('OnboardingType.', '')) {
      case "signupComplete":
        return OnboardingType.signupComplete;
      case "oneOnOneMeetingCreation":
        return OnboardingType.oneOnOneMeetingCreation;
      case "groupMeetingCreation":
        return OnboardingType.groupMeetingCreation;
      case "meetingJoining":
        return OnboardingType.meetingJoining;
      case "meetingLeaving":
        return OnboardingType.meetingLeaving;
    }
    return OnboardingType.signupComplete;
  }

  List<OnboardingSlideContent> slidesForType(
      OnboardingType onboardingType, BuildContext context) {
    switch (onboardingType) {
      case OnboardingType.signupComplete:
        final user = BlocProvider.of<AuthBloc>(context).state.user;
        return signupSlides
            .map((e) => OnboardingSlideContent(
                  heading: e.heading.replaceFirst('NAME', user?.name ?? ''),
                  subHeading: e.subHeading,
                  image: e.image,
                  buttons: e.buttons,
                ))
            .toList();
      case OnboardingType.oneOnOneMeetingCreation:
        return oneOnOneCreationSlides;
      case OnboardingType.groupMeetingCreation:
        return groupCreationSlides;
      case OnboardingType.meetingJoining:
        return meetingJoiningSlides;
      case OnboardingType.meetingLeaving:
        return meetingLeavingSlides;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final onboardingType = typeFromString(type);
    final slideContent = slidesForType(onboardingType, context);
    final pageController = usePageController();
    final currentPage = useState(0);

    useEffect(() {
      void listener() {
        currentPage.value = pageController.page!.floor();
      }

      pageController.addListener(listener);

      return () {
        pageController.removeListener(listener);
      };
    }, []);

    return Scaffold(
      body: Stack(
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
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: kbottomBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildActionButtons(
                      context,
                      pageController,
                      currentPage.value,
                      slideContent[currentPage.value].buttons,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildActionButtons(
    BuildContext context,
    PageController controller,
    int currentPage,
    List<OnboardingSlideButton> buttons,
  ) {
    const duration = Duration(milliseconds: 200);
    return buttons.map((e) {
      switch (e.type) {
        case OnboardingSlideButtonType.next:
          return _ActionButton(
            label: e.title,
            onTap: () {
              controller.animateToPage(currentPage + 1,
                  duration: duration, curve: Curves.easeInOut);
            },
          );
        case OnboardingSlideButtonType.invite:
          final shareManager = useProvider(shareManagerProvider);
          return _ActionButton(
            label: e.title,
            onTap: () async {
              await shareManager.share(context);

              AutoRouter.of(context).pushAndPopUntil(HomeScreenRoute(tab: 0),
                  predicate: (route) => false);
            },
          );
        case OnboardingSlideButtonType.feedback:
          return _ActionButton(
            label: e.title,
            onTap: () async {
              final user = BlocProvider.of<AuthBloc>(context).state.user;

              AutoRouter.of(context).pushAndPopUntil(HomeScreenRoute(tab: 0),
                  predicate: (route) => false);

              launch(
                'https://worknetwork.typeform.com/to/dpmbWtYv#email=${user?.email}',
                option: const CustomTabsOption(
                  enableUrlBarHiding: true,
                  extraCustomTabs: [],
                  showPageTitle: false,
                  enableInstantApps: false,
                ),
              );
            },
          );
        case OnboardingSlideButtonType.start1on1Conversation:
          return _ActionButton(
            label: e.title,
            onTap: () {
              context.read(onboardingProvider).setOnboardingShown();
              AutoRouter.of(context).pushAndPopUntil(HomeScreenRoute(),
                  predicate: (route) => false);
              AutoRouter.of(context).push(TopicsListRoute(showTitle: true));
            },
          );
        case OnboardingSlideButtonType.startGroupConversation:
          return _ActionButton(
            label: e.title,
            onTap: () {
              context.read(onboardingProvider).setOnboardingShown();
              AutoRouter.of(context).pushAndPopUntil(HomeScreenRoute(),
                  predicate: (route) => false);
            },
          );
        case OnboardingSlideButtonType.joinConversation:
          return _ActionButton(
            label: e.title,
            onTap: () {
              context.read(onboardingProvider).setOnboardingShown();
              AutoRouter.of(context).pushAndPopUntil(HomeScreenRoute(tab: 1),
                  predicate: (route) => false);
            },
          );
        default:
          return _ActionButton(
            label: e.title,
            isDismiss: true,
            onTap: () {
              AutoRouter.of(context).pushAndPopUntil(HomeScreenRoute(tab: 0),
                  predicate: (route) => false);
            },
          );
      }
    }).toList();
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
        Expanded(child: Container()),
      ],
    );
  }
}

class _PageContent extends StatelessWidget {
  final OnboardingSlideContent content;

  const _PageContent({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline6;
    final subheadStyle = Theme.of(context).textTheme.subtitle1;
    return Column(
      children: [
        SizedBox(
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
                const SizedBox(height: 20),
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
  final VoidCallback? onTap;
  final bool isDismiss;

  const _ActionButton({
    Key? key,
    required this.label,
    this.onTap,
    this.isDismiss = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BaseLargeButton(
          outlined: isDismiss,
          onPressed: onTap,
          text: label,
        ),
      ),
    );
  }
}

const signupSlides = [
  OnboardingSlideContent(
    heading: "Hi NAME",
    subHeading: "Your network is waiting for you.",
    image: AppImageAssets.onboardingHello,
    buttons: [
      OnboardingSlideButton(
          title: 'Get started', type: OnboardingSlideButtonType.next)
    ],
  ),
  OnboardingSlideContent(
    heading: "",
    subHeading: "You can meet people via 1-on-1 or group conversations",
    image: AppImageAssets.onboardinCall,
  ),
  OnboardingSlideContent(
    heading: "",
    subHeading: "Start by picking a topic that interests you",
    image: AppImageAssets.splashTopic,
  ),
  OnboardingSlideContent(
    heading: "",
    subHeading: "Pick whom you want to meet & at what time",
    image: AppImageAssets.splashPeople,
  ),
  OnboardingSlideContent(
    heading: "",
    subHeading: "We will match you with like minded people",
    image: AppImageAssets.splashConversation,
  ),
  OnboardingSlideContent(
    heading: "",
    subHeading: "All you have to do is join the conversation",
    image: AppImageAssets.splashDiscover,
  ),
  OnboardingSlideContent(
    heading: "",
    subHeading:
        "You can also explore on-going conversations & drop in to converse",
    image: AppImageAssets.onboardingGroupCards,
  ),
  OnboardingSlideContent(
    heading: "",
    subHeading: "Let’s set up your first 1:1 meeting",
    image: AppImageAssets.splashAI,
    buttons: [
      OnboardingSlideButton(
          title: 'Pick a Topic',
          type: OnboardingSlideButtonType.start1on1Conversation),
    ],
  ),
];

const oneOnOneCreationSlides = [
  OnboardingSlideContent(
    heading: "You are all set",
    subHeading:
        "Once your meeting is set up & you will get notified & will receive an introduction to your match with the meeting link.",
    image: AppImageAssets.splashConversation,
  ),
  OnboardingSlideContent(
    heading: "View upcoming meetings",
    subHeading: "You can view your upcoming meetings in the my meetings tab",
    image: AppImageAssets.onboardingGroupCards,
  ),
  OnboardingSlideContent(
    heading: "Invite your friends",
    subHeading: "Would you like to invite others to the community",
    image: AppImageAssets.splashPeople,
    buttons: [
      OnboardingSlideButton(
          title: 'Not now', type: OnboardingSlideButtonType.dismiss),
      OnboardingSlideButton(
          title: 'Invite', type: OnboardingSlideButtonType.invite),
    ],
  ),
];

const groupCreationSlides = [
  OnboardingSlideContent(
    heading: "You are all set",
    subHeading:
        "We will begin sending invites to relevant people to join your conversation.",
    image: AppImageAssets.splashAI,
  ),
  OnboardingSlideContent(
    heading: "All you have to do is join",
    subHeading:
        "At the meeting time, you will be notified & all you have to do is join the conversation",
    image: AppImageAssets.splashDiscover,
  ),
  OnboardingSlideContent(
    heading: "Invite your colleagues ?",
    subHeading: "You can also invite your friends to join the conversation ",
    image: AppImageAssets.splashPeople,
    buttons: [
      OnboardingSlideButton(
          title: 'Not now', type: OnboardingSlideButtonType.dismiss),
      OnboardingSlideButton(
          title: 'Invite', type: OnboardingSlideButtonType.invite),
    ],
  ),
];

const meetingJoiningSlides = [
  OnboardingSlideContent(
    heading: "You are all set",
    subHeading:
        "Once the meeting starts all you have to do is join the conversation ",
    image: AppImageAssets.splashAI,
  ),
  OnboardingSlideContent(
    heading: "Invite your colleagues ?",
    subHeading: "You can also invite your friends to join the conversation",
    image: AppImageAssets.splashPeople,
    buttons: [
      OnboardingSlideButton(
          title: 'Not now', type: OnboardingSlideButtonType.dismiss),
      OnboardingSlideButton(
          title: 'Invite', type: OnboardingSlideButtonType.invite),
    ],
  ),
];

const meetingLeavingSlides = [
  OnboardingSlideContent(
    heading: "How was your conversation?",
    subHeading:
        "You can share feedback on the conversation to improve future matches",
    image: AppImageAssets.feedback,
    buttons: [
      OnboardingSlideButton(
          title: 'Not now', type: OnboardingSlideButtonType.dismiss),
      OnboardingSlideButton(
          title: 'Share Feedback', type: OnboardingSlideButtonType.feedback),
    ],
  ),
];

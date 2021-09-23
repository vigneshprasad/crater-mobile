import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../ui/base/social_auth_button/social_auth_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../../bloc/auth_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AuthBloc _authBloc;
  late TabController _tabController;
  late int _activeIndex;

  final List<Widget> _tabs = const [
    _ImageSlide(
      image: AppImageAssets.splashDiscover,
      heading: "A new kind of professional social network",
      subheading:
          "We enable you to discover & converse with relevant professionals, to discuss your professional objectives & trending topics. Powered by AI",
    ),
    _ImageSlide(
      image: AppImageAssets.splashTopic,
      heading: "Step 1: Pick a topic",
      subheading: "Pick an objective or a trending topic you wish to discuss",
    ),
    _ImageSlide(
      image: AppImageAssets.splashPeople,
      heading: "Step 2: Choose whom to meet & when",
      subheading:
          "Simply choose the profession of the person you want to converse with & when",
    ),
    _ImageSlide(
      image: AppImageAssets.splashAI,
      heading: "Our AI goes to work",
      subheading: "Our AI will search for the post possible match for you",
    ),
    _ImageSlide(
      image: AppImageAssets.splashConversation,
      heading: "Your 1:1 or group conversation is set up",
      subheading:
          "You will be matched with 1 or more people, for a conversation.",
    ),
    _ImageSlide(
      image: AppImageAssets.splashVirtual,
      heading: "Step 3: Join the call",
      subheading:
          "All you have to do is join the call & start conversing & networking.",
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _activeIndex = _tabController.index;
    _tabController.addListener(_tabChangeListener);
    _authBloc = BlocProvider.of<AuthBloc>(context);
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSuccess) {
          // navigatePostAuth(state.user, profile: state.profile);
        } else if (state is AuthRequestFailure) {
          _handleRequestError(state);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ScaffoldContainer(
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
                    if (state.isSubmitting != null && state.isSubmitting!)
                      _buildOverlay(context)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: AppInsets.xl),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRequestError(AuthRequestFailure state) {
    final failure = state.error as ServerFailure;
    if (failure.message != null) {
      final json = jsonDecode(failure.message.toString());
      showDialog(
        context: context,
        builder: (context) {
          final title =
              AppLocalizations.of(context)?.translate("auth:login_fail_title");
          final dismiss =
              AppLocalizations.of(context)?.translate("dismiss")?.toUpperCase();
          return AlertDialog(
            title: Text(title!),
            content: Text(json["non_field_errors"][0] as String),
            actions: [
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).pop();
                },
                child: Text(dismiss!),
              )
            ],
          );
        },
      );
    } else {
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
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
                  child: BaseLargeButton(
                    text: 'Get Started',
                    onPressed: () => openBottomSheet(context),
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
    _openPhoneAuthScreen(isSignUp, context);

    return;

    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return _popup(context, isSignUp: isSignUp);
      },
    );
  }

  Widget _popup(BuildContext context, {bool isSignUp = true}) {
    final headerText = isSignUp ? 'Create a new account' : 'Sign in';
    final subHeaderText = !isSignUp
        ? 'To continue conversing & growing your network.'
        : 'Have conversations & grow your network.';

    final buttonWidth = MediaQuery.of(context).size.width / 2 - 55;
    const buttonHeight = 112.0;

    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
          topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          padding: const EdgeInsets.all(40),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: [
                      Text(
                        headerText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 17),
                      ),
                      const SizedBox(height: 8),
                      Text(subHeaderText),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  children: [
                    if (!isSignUp)
                      BaseContainer(
                        child: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: SocialAuthButton(
                            provider: SocialAuthProviders.google,
                            isLarge: true,
                            isSignUp: isSignUp,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _authBloc.add(const AuthSocialPressed(
                                  provider: SocialAuthProviders.google));
                            },
                          ),
                        ),
                      ),
                    if (Platform.isIOS)
                      BaseContainer(
                        child: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: SocialAuthButton(
                            provider: SocialAuthProviders.apple,
                            isLarge: true,
                            isSignUp: isSignUp,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _authBloc.add(const AuthSocialPressed(
                                  provider: SocialAuthProviders.apple));
                            },
                          ),
                        ),
                      ),
                    BaseContainer(
                      child: SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: SocialAuthButton(
                          provider: SocialAuthProviders.linkedin,
                          isLarge: true,
                          isSignUp: isSignUp,
                          onPressed: _onPressedLinkedIn,
                        ),
                      ),
                    ),
                    if (!isSignUp)
                      BaseContainer(
                        child: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: SocialAuthButton(
                            provider: SocialAuthProviders.facebook,
                            isLarge: true,
                            isSignUp: isSignUp,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _authBloc.add(const AuthSocialPressed(
                                  provider: SocialAuthProviders.facebook));
                            },
                          ),
                        ),
                      ),
                    if (!isSignUp || !kReleaseMode)
                      BaseContainer(
                        child: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: SocialAuthButton(
                            provider: SocialAuthProviders.email,
                            isLarge: true,
                            isSignUp: isSignUp,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _openSignupAuthScreen(isSignUp, context);
                            },
                          ),
                        ),
                      ),
                    if (!isSignUp)
                      BaseContainer(
                        child: SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: SocialAuthButton(
                            provider: SocialAuthProviders.phone,
                            isLarge: true,
                            isSignUp: isSignUp,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _openPhoneAuthScreen(isSignUp, context);
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void _onPressedLinkedIn() {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LinkedInUserWidget(
        appBar: BaseAppBar(),
        redirectUrl: ConfigReader.getLinkedInRedirect(),
        clientId: ConfigReader.getLinkedInClientId(),
        clientSecret: ConfigReader.getLinkedInSecret(),
        onGetUserProfile: (UserSucceededAction linkedInUser) async {
          Navigator.of(context).pop();
          _authBloc.add(AuthLinkedTokenRecieved(
              token: linkedInUser.user.token.accessToken!));
        },
        onError: (UserFailedAction e) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: e.toString());
        },
      );
    }));
  }

  void _openSignupAuthScreen(bool showSignup, BuildContext context) {
    final state = showSignup ? "signup" : "signin";
    AutoRouter.of(context).push(AuthScreenRoute(state: state));
  }

  void _openPhoneAuthScreen(bool isSignUp, BuildContext context) {
    final state = isSignUp ? "signup" : "signin";
    AutoRouter.of(context).push(PhoneScreenRoute(state: state));
  }
}

class _ImageSlide extends StatelessWidget {
  final ImageProvider image;
  final String heading;
  final String subheading;
  final double imageWidth;

  const _ImageSlide({
    Key? key,
    required this.image,
    required this.heading,
    required this.subheading,
    this.imageWidth = double.infinity,
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
      child: Column(children: [
        const Spacer(),
        Image(
          image: image,
          width: imageWidth,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
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
          ),
        )
      ]),
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

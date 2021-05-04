import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/social_auth/domain/usecase/get_social_auth_token.dart';
import 'package:worknetwork/ui/base/social_auth_button/social_auth_button.dart';
import 'package:worknetwork/utils/app_localizations.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../routes.gr.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AuthBloc _authBloc;
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
          "Our AI engine will search for the best possible match for you.",
    ),
    _ImageSlide(
      image: AppImageAssets.splashConversation,
      heading: "04.\nYour conversation is set up",
      subheading:
          "You will be matched with 1 or more people\nfor the conversation",
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
          navigatePostAuth(state.user, profile: state.profile);
        } else if (state is AuthRequestFailure) {
          _handleRequestError(state);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
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
                if (state.isSubmitting != null && state.isSubmitting)
                  _buildOverlay(context)
              ],
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: AppInsets.xl),
              const Text("Loading..."),
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
              AppLocalizations.of(context).translate("auth:login_fail_title");
          final dismiss =
              AppLocalizations.of(context).translate("dismiss").toUpperCase();
          return AlertDialog(
            title: Text(title),
            content: Text(json["non_field_errors"][0] as String),
            actions: [
              FlatButton(
                onPressed: () {
                  ExtendedNavigator.of(context).pop();
                },
                child: Text(dismiss),
              )
            ],
          );
        },
      );
    } else {
      Fluttertoast.showToast(msg: failure.message as String);
    }
  }

  Widget _buildViewContent(BuildContext context) {
    final footerText =
        '${AppLocalizations.of(context).translate('auth:signin_text')} ${AppLocalizations.of(context).translate('auth:signin')}';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.xxl),
            child: Column(
              children: [
                SizedBox(
                  width: 240,
                  child: SocialAuthButton(
                    provider: SocialAuthProviders.linkedin,
                    isLarge: true,
                    onPressed: () => _authBloc.add(const AuthSocialPressed(
                        provider: SocialAuthProviders.linkedin)),
                  ),
                ),
                const SizedBox(height: AppInsets.med),
                SizedBox(
                  width: 240,
                  child: SocialAuthButton(
                    provider: SocialAuthProviders.apple,
                    isLarge: true,
                    onPressed: () => _authBloc.add(const AuthSocialPressed(
                        provider: SocialAuthProviders.apple)),
                  ),
                ),
                const SizedBox(height: AppInsets.med),
                SizedBox(
                  height: 30,
                  child: FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _openSignupAuthScreen(false, context);
                    },
                    child: Text(footerText),
                  ),
                ),
              ],
            ),
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
      padding: const EdgeInsets.only(top: 40.0, bottom: 260),
      child: Column(children: [
        const Spacer(),
        Image(
          image: image,
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

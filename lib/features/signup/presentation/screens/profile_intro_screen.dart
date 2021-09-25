import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/social_auth/domain/usecase/get_social_auth_token.dart';

import '../../../../constants/app_constants.dart';
import '../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/profile_intro_question.dart';
import '../bloc/profile_intro/profile_intro_bloc.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_inline_question.dart';

class ProfileIntroScreen extends StatefulWidget {
  final bool editMode;

  const ProfileIntroScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
  }) : super(key: key);

  @override
  _ProfileIntroScreenState createState() => _ProfileIntroScreenState();
}

class _ProfileIntroScreenState extends State<ProfileIntroScreen> {
  late List<ProfileIntroQuestion> _allQuestions;
  late List<ProfileIntroElement> _elements;
  late int _visibleQuestions;
  late bool _showSubmit;
  late ProfileIntroBloc _bloc;
  late Map<String, dynamic> _values;
  File? _photo;
  String? _photoUrl;
  late String _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> editedFieldIds = [];
  bool allowSkip = false;
  OverlayEntry? _overlay;

  @override
  void initState() {
    _elements = [];
    _allQuestions = [];
    _values = {};
    _visibleQuestions = 0;
    _showSubmit = false;
    final user = BlocProvider.of<AuthBloc>(context).state.user!;
    _bloc = KiwiContainer().resolve<ProfileIntroBloc>()
      ..add(GetProfileIntroRequestStarted(user: user));

    _name = user.name ?? '';
    _photoUrl = user.photo ?? '';

    // Prefill Values in Editing mode
    final profile = BlocProvider.of<AuthBloc>(context).state.profile;
    if (widget.editMode == true && profile != null) {
      _values[ProfileIntroElement.educationLevel] = profile.educationLevel;
      _values[ProfileIntroElement.yearsOfExperience] =
          profile.yearsOfExperience;
      _values[ProfileIntroElement.sector] = profile.sector;
      _values[ProfileIntroElement.companyType] = profile.companyType;
    } else if (widget.editMode == false) {
      SharedPreferences.getInstance().then((prefs) {
        final provider = prefs.getString('AuthProvider');
        if (provider == SocialAuthProviders.apple.toString()) {
          setState(() {
            allowSkip = true;
          });
        }
      });
    }

    if (_photoUrl == null) {
      if (_name.trim().isNotEmpty) {
        final letter = _name.substring(0, 1).toLowerCase();
        _photoUrl = AppConstants.defaultAvatar[letter];
      } else {
        _photoUrl = AppConstants.defaultAvatar["default"];
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      const title = 'A bit more about what you do';

      return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileIntroBloc, ProfileIntroState>(
              listener: _blocListener,
              builder: (context, state) {
                return Scaffold(
                  appBar: BaseAppBar(),
                  body: ScaffoldContainer(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const ProfileHeader(title: title),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Form(
                                      key: _formKey,
                                      child: ProfileInlineQuestion(
                                        elements: _elements,
                                        values: _values,
                                        animateText: widget.editMode == false,
                                        onValuesChange: (id, value) {
                                          _values[id] = value;

                                          if (!editedFieldIds.contains(id)) {
                                            editedFieldIds.add(id);
                                            showNextQuestion();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (_showSubmit || allowSkip)
                          ProfileFooter(
                            onSave: submitAnswers,
                            onSkip: allowSkip ? goToNextScreen : null,
                          )
                      ],
                    ),
                  ),
                );
              }));
    });
  }

  void submitAnswers() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _overlay = buildLoaderOverlay();
      Overlay.of(context)?.insert(_overlay!);
      _bloc.add(PostProfileIntroRequestStarted(
        values: _values,
        photo: _photo,
      ));
    }
  }

  void showNextQuestion() {
    if (_visibleQuestions < _allQuestions.length) {
      final nextQuestion = _allQuestions[_visibleQuestions];
      appendQuestionElement(nextQuestion);
      _visibleQuestions++;
    }

    final allRequiredQuestionsDone = _visibleQuestions == _allQuestions.length;
    if (allRequiredQuestionsDone) {
      setState(() {
        _showSubmit = true;
      });
    }
  }

  void appendQuestionElement(ProfileIntroQuestion question) {
    if (question.elements.isEmpty) {
      return;
    }
    // Adds one word at a time. Each word is added after animation of previous word.
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      setState(() {
        _elements.add(question.elements[0]);
      });
      question.elements.removeAt(0);
      appendQuestionElement(question);
    });
  }

  void _blocListener(BuildContext context, ProfileIntroState state) {
    if (state is ProfileIntroRequestLoaded) {
      _allQuestions = state.questions;
      if (widget.editMode == true) {
        _visibleQuestions = _allQuestions.length;
        for (final element in _allQuestions) {
          _elements.addAll(element.elements);
        }
        Future.delayed(const Duration(seconds: 1)).then((value) {
          setState(() {
            _showSubmit = true;
          });
        });
      } else {
        showNextQuestion();
      }
    } else if (state is PatchProfileIntroRequestLoaded) {
      final _ = BlocProvider.of<AuthBloc>(context)
        ..add(AuthUserProfileUpdateRecieved(profile: state.profile));
      _overlay?.remove();
      goToNextScreen();
    }
  }

  void goToNextScreen() {
    AutoRouter.of(context)
        .push(ProfileImageScreenRoute(editMode: widget.editMode));
  }
}

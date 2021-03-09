import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/widgets/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_question.dart';
import 'package:worknetwork/features/signup/presentation/bloc/profile_intro/profile_intro_bloc.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_inline_question.dart';
import 'package:worknetwork/features/signup/presentation/widgets/profile_photo_picker.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../routes.gr.dart';

class ProfileIntroScreen extends StatefulWidget {
  final bool editMode;

  const ProfileIntroScreen({
    Key key,
    @PathParam("editMode") this.editMode,
  }) : super(key: key);

  @override
  _ProfileIntroScreenState createState() => _ProfileIntroScreenState();
}

class _ProfileIntroScreenState extends State<ProfileIntroScreen> {
  List<ProfileIntroQuestion> _allQuestions;
  List<ProfileIntroElement> _elements;
  int _visibleQuestions;
  bool _showSubmit;
  ProfileIntroBloc _bloc;
  Map<String, dynamic> _values;
  File _photo;
  String _photoUrl;
  String _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _elements = [];
    _allQuestions = [];
    _values = {};
    _visibleQuestions = 0;
    _showSubmit = false;
    _bloc = KiwiContainer().resolve<ProfileIntroBloc>()
      ..add(const GetProfileIntroRequestStarted());

    _name = BlocProvider.of<AuthBloc>(context).state.user.name;
    _photoUrl = BlocProvider.of<AuthBloc>(context).state.user.photo;

    // Prefill Values in Editing mode
    _values[ProfileIntroElement.name] = _name;
    if (widget.editMode == true) {
      final profile = BlocProvider.of<AuthBloc>(context).state.profile;
      _values[ProfileIntroElement.educationLevel] = profile.educationLevel;
      _values[ProfileIntroElement.yearsOfExperience] =
          profile.yearsOfExperience;
      _values[ProfileIntroElement.sector] = profile.sector;
      _values[ProfileIntroElement.companyType] = profile.companyType;
      _values[ProfileIntroElement.tags] = BlocProvider.of<AuthBloc>(context)
          .state
          .profile
          .tagList
          .map((e) => ProfileIntroMeta(name: e.name, value: e.pk))
          .toList();
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
      final user = authState.user;
      final name = user.name;
      const title = 'How would you describe yourself';
      const info = 'Just the basics, you can add more later.';
      final submit = AppLocalizations.of(context).translate("thats_accurate");

      return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileIntroBloc, ProfileIntroState>(
              listener: _blocListener,
              builder: (context, state) {
                return Scaffold(
                    extendBody: true,
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    body: SingleChildScrollView(
                      child: SafeArea(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              widget.editMode == false
                                  ? Column(
                                      children: [
                                        Text(title,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                        Text(info,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                      ],
                                    )
                                  : Container(),
                              Container(height: 20),
                              Center(
                                  child: ProfilePhotoPicker(
                                photoUrl: _photoUrl,
                                onChoosePhoto: (photo) => _photo = photo,
                              )),
                              Container(height: 20),
                              Form(
                                key: _formKey,
                                child: ProfileInlineQuestion(
                                  elements: _elements,
                                  values: _values,
                                  animateText: widget.editMode == false,
                                  onValuesChange: (id, value) {
                                    _values[id] = value;

                                    final e = _elements.firstWhere(
                                        (element) => element.id == id);
                                    if (e.type !=
                                        ProfileIntroElementType.text) {
                                      showNextQuestion();
                                    }
                                  },
                                ),
                              ),
                              Container(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                        color: Colors.transparent,
                        height: 80,
                        child: _showSubmit
                            ? Center(
                                child: SizedBox(
                                  width: 200,
                                  child: BaseLargeButton(
                                      onPressed: submitAnswers,
                                      child: Text(submit)),
                                ),
                              )
                            : Container()));
              }));
    });
  }

  void submitAnswers() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _bloc.add(PostProfileIntroRequestStarted(
        values: _values,
        photo: _photo,
      ));
    }
  }

  void showNextQuestion() {
    if (_visibleQuestions < _allQuestions.length) {
      final nextQuestion = _allQuestions[_visibleQuestions];
      appendQuestion(nextQuestion);
      _visibleQuestions++;
    } else {
      setState(() {
        _showSubmit = true;
      });
    }
  }

  void appendQuestion(ProfileIntroQuestion question) {
    if (question.elements.isEmpty) {
      return;
    }
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      setState(() {
        _elements.add(question.elements[0]);
      });
      question.elements.removeAt(0);
      appendQuestion(question);
    });
  }

  void _blocListener(BuildContext context, ProfileIntroState state) {
    if (state is ProfileIntroRequestLoaded) {
      _allQuestions = state.questions;
      if (widget.editMode == true) {
        _visibleQuestions = _allQuestions.length;
        _allQuestions.forEach((element) {
          _elements.addAll(element.elements);
        });
        Future.delayed(Duration(seconds: 1)).then((value) {
          setState(() {
            _showSubmit = true;
          });
        });
      } else {
        showNextQuestion();
      }
    } else if (state is PatchProfileIntroRequestLoaded) {
      final bloc = BlocProvider.of<AuthBloc>(context)
        ..add(AuthUserUpdateRecieved(user: state.user))
        ..add(AuthUserProfileUpdateRecieved(profile: state.profile));
      if (state.user.linkedinUrl == null) {
        ExtendedNavigator.of(context).popAndPush(Routes.profileSetupScreen);
      } else {
        ExtendedNavigator.of(context).popAndPush(Routes.homeScreen(tab: 0));
      }
    }
  }
}

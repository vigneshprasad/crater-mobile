import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/signup/data/repository/profile_meta_repository_impl.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_multi_select_dropdown/base_multi_select_dropdown.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../data/models/profile_extra_meta/profile_extra_meta.dart';
import '../../widgets/profile_footer.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/profile_intro_form/profile_form_dropdown.dart';
import '../../widgets/profile_intro_form/profile_form_input.dart';
import 'profile_extra_info_state.dart';

typedef FormValueChangeCallback<T> = void Function(String key, T value);

class ProfileExtraInfoScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final profile = BlocProvider.of<AuthBloc>(context).state.profile;
    final state = useProvider(
        profileFormMetaStateProvider(profile.tagList.first.pk).state);
    return Scaffold(
      appBar: BaseAppBar(),
      body: state.when(
        loading: () => Container(),
        data: (meta) => _ProflieIntroLoaded(meta: meta),
        error: (err, st) => Container(),
      ),
    );
  }
}

class _ProflieIntroLoaded extends HookWidget {
  final ProfileExtraMeta meta;

  const _ProflieIntroLoaded({
    @required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = useState(GlobalKey<FormState>());
    final _formData = useState<Map<String, dynamic>>({});
    final showFooter = useState(false);
    return Column(
      children: [
        const ProfileHeader(title: "A bit more about what you do"),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppInsets.med,
            horizontal: AppInsets.xl,
          ),
          child: _ProfileIntroForm(
            meta: meta,
            formKey: _formKey.value,
            formData: _formData,
            onAllQuestionsShown: () {
              showFooter.value = true;
            },
          ),
        )),
        if (showFooter.value)
          ProfileFooter(
            onSave: () {
              final isValid = _formKey.value.currentState.validate();

              if (isValid) {
                final data = {
                  ..._formData.value,
                  'profile_intro_updated': true,
                };
                _postProfileData(context, data);
              }
            },
          ),
      ],
    );
  }

  Future<void> _postProfileData(
      BuildContext context, Map<String, dynamic> data) async {
    final _overlay = _buildLoaderOverlay();

    Overlay.of(context).insert(_overlay);

    final result =
        await context.read(profileMetaRepositoryProvider).postUserProfile(data);

    _overlay.remove();

    result.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
      },
      (profile) {
        AutoRouter.of(context).push(Routes.profileImageScreen(editMode: false));
      },
    );
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black.withOpacity(0.6),
          child: const Center(
            child: SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileIntroForm extends HookWidget {
  final GlobalKey<FormState> formKey;
  final ProfileExtraMeta meta;
  final ValueNotifier<Map<String, dynamic>> formData;
  final VoidCallback onAllQuestionsShown;

  static const kquestionAnimationDuration = Duration(seconds: 1);

  const _ProfileIntroForm({
    @required this.meta,
    @required this.formKey,
    @required this.formData,
    this.onAllQuestionsShown,
  });

  @override
  Widget build(BuildContext context) {
    final questions = meta.question.split(".");
    final questionIndex = useState(0);

    final controllers = questions
        .map(
            (e) => useAnimationController(duration: kquestionAnimationDuration))
        .toList();

    useEffect(() {
      controllers[0].animateTo(1);
      return;
    }, []);

    return SingleChildScrollView(
      child: _AnimatedForm.fromMeta(
        controllers: controllers,
        meta: meta,
        formKey: formKey,
        onRenderNextQuestion: () {
          if (questionIndex.value < questions.length - 1) {
            questionIndex.value = questionIndex.value + 1;
            controllers[questionIndex.value].animateTo(1);
          } else {
            if (onAllQuestionsShown != null) {
              onAllQuestionsShown();
            }
          }
        },
        onFormValueChanged: (key, value) {
          formData.value = {
            ...formData.value,
            key: value,
          };
        },
      ),
    );
  }
}

class _AnimatedForm extends StatelessWidget {
  final List<String> questions;
  final List<List<Animation<int>>> animations;
  final List<AnimationController> controllers;
  final ProfileExtraMeta meta;
  final GlobalKey<FormState> formKey;
  final VoidCallback onRenderNextQuestion;
  final FormValueChangeCallback<dynamic> onFormValueChanged;

  const _AnimatedForm({
    Key key,
    this.questions,
    this.animations,
    this.controllers,
    this.meta,
    this.formKey,
    this.onRenderNextQuestion,
    this.onFormValueChanged,
  }) : super(key: key);

  factory _AnimatedForm.fromMeta({
    List<AnimationController> controllers,
    ProfileExtraMeta meta,
    GlobalKey<FormState> formKey,
    VoidCallback onRenderNextQuestion,
    FormValueChangeCallback<dynamic> onFormValueChanged,
  }) {
    final questions =
        meta.question.split(".").map((question) => "$question .").toList();
    final List<List<Animation<int>>> animations = [];

    for (int qIndex = 0; qIndex < questions.length; qIndex++) {
      final List<Animation<int>> items = [];
      final question = questions[qIndex];
      final controller = controllers[qIndex];
      final words = question.split(" ");
      final fraction = 1 / words.length;

      for (int wIndex = 0; wIndex < words.length; wIndex++) {
        final word = words[wIndex];
        final startInterval = wIndex * fraction;
        final endInterval = (wIndex + 1) * fraction;

        items.add(StepTween(
          begin: 0,
          end: word.length,
        ).animate(
          CurvedAnimation(
            curve: Interval(startInterval, endInterval),
            parent: controller,
          ),
        ));
      }

      animations.add(items);
    }

    return _AnimatedForm(
      animations: animations,
      questions: questions,
      controllers: controllers,
      meta: meta,
      formKey: formKey,
      onRenderNextQuestion: onRenderNextQuestion,
      onFormValueChanged: onFormValueChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];
    final textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 16.00,
          height: 2.5,
        );

    for (int qIndex = 0; qIndex < animations.length; qIndex++) {
      final question = questions[qIndex];
      final questionAnimations = animations[qIndex];
      final words = question.split(" ");

      for (int aIndex = 0; aIndex < questionAnimations.length; aIndex++) {
        final animation = questionAnimations[aIndex];
        final word = words[aIndex];

        if (word.startsWith("{")) {
          final key = word.substring(1, word.length - 1);
          widgets.add(
            AnimatedBuilder(
              animation: controllers[qIndex],
              builder: (context, child) {
                return animation.isCompleted ? getFormField(key) : Container();
              },
            ),
          );
        } else {
          widgets.add(
            AnimatedBuilder(
              animation: controllers[qIndex],
              builder: (context, child) {
                final end = animation.value;
                final string = word.substring(0, end);
                return Text("$string ", style: textStyle);
              },
            ),
          );
        }
      }
    }

    return Form(
      key: formKey,
      child: Wrap(
        children: widgets,
      ),
    );
  }

  Widget getFormField(
    String key,
  ) {
    final data = meta.meta[key];

    if (data != null) {
      switch (data.type) {
        case FieldType.dropDown:
          return ProfileFormDropDown<Option>(
            items: data.options,
            labelGetter: (item) => item.name,
            validator: (value) =>
                value != null ? null : "Please provide a value",
            onChanged: (value) {
              if (onFormValueChanged != null) {
                onFormValueChanged(key, value.value);
              }
              if (onRenderNextQuestion != null) {
                onRenderNextQuestion();
              }
            },
          );

        case FieldType.textField:
          return ProfileFormInput(
            onChanged: (value) {
              if (onFormValueChanged != null) {
                onFormValueChanged(key, value);
              }
            },
            onFieldSubmitted: (value) {
              if (onRenderNextQuestion != null) {
                onRenderNextQuestion();
              }
            },
            validator: (value) =>
                value.isEmpty ? "Please provide a value" : null,
          );

        case FieldType.multiSelect:
          return BaseMultiSelectDropdownFormField<Option>(
            items: data.options,
            validator: (value) =>
                value.isEmpty ? "Please provide a value" : null,
            onChanged: (value) {
              if (onFormValueChanged != null) {
                final data = value.map((e) => e.value).toList();
                onFormValueChanged(key, data);
              }

              if (onRenderNextQuestion != null) {
                onRenderNextQuestion();
              }
            },
          );

        default:
          return Container();
      }
    } else {
      return Container();
    }
  }
}

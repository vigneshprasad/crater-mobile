import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/user_objective_entity.dart';
import '../bloc/objectives/objectives_bloc.dart';
import '../widgets/objectives_picker.dart';

class ObjectivesScreen extends StatefulWidget {
  @override
  _ObjectivesScreenState createState() => _ObjectivesScreenState();
}

class _ObjectivesScreenState extends State<ObjectivesScreen> {
  ObjectivesBloc _bloc;
  List<UserObjective> _objectives;
  List<UserObjective> _selectedObjectives;
  List<UserObjective> _interests;
  List<UserObjective> _selectedInterests;

  @override
  void initState() {
    _selectedObjectives = [];
    _objectives = [];
    _selectedInterests = [];
    _interests = [];
    _bloc = KiwiContainer().resolve<ObjectivesBloc>()
      ..add(const GetObjectivesRequestStarted());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        String heading = 'And about your interests';
        final next =
            AppLocalizations.of(context).translate("next").toUpperCase();

        final headingStyle = Theme.of(context).textTheme.headline5.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            );
        return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ObjectivesBloc, ObjectivesState>(
            listener: _blocListener,
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppInsets.xl),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppInsets.xl,
                                ),
                                child: Text(
                                  heading,
                                  style: headingStyle,
                                ),
                              ),
                              const SizedBox(height: AppInsets.xxl),
                              Text('I like to converse about',
                                  style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(height: AppInsets.xxl),
                              if (_interests.isNotEmpty)
                                ObjectivesPicker(
                                  objectives: _interests
                                      .map((e) => PickerItem(name: e.name))
                                      .toList(),
                                  onPressedItem: _onPressedInterestItem,
                                ),
                              const SizedBox(height: AppInsets.xxl),
                              Text('My professional objectives',
                                  style: Theme.of(context).textTheme.subtitle1),
                              const SizedBox(height: AppInsets.xxl),
                              if (_objectives.isNotEmpty)
                                ObjectivesPicker(
                                  objectives: _objectives
                                      .map((e) => PickerItem(name: e.name))
                                      .toList(),
                                  onPressedItem: _onPressedObjectiveItem,
                                ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppInsets.xxl),
                            child: BaseLargeButton(
                              text: next,
                              onPressed: _selectedObjectives.isNotEmpty
                                  ? _onPressSubmit
                                  : null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _blocListener(BuildContext context, ObjectivesState state) {
    if (state is ObjectivesRequestLoaded) {
      setState(() {
        _objectives = state.objectives;
      });
    } else if (state is PatchObjectivesRequestLoaded) {
      ExtendedNavigator.of(context)
          .popAndPush(Routes.profileImageScreen(editMode: true));
    }
  }

  void _onPressSubmit() {
    _bloc.add(PostObjectivesRequestStarted(objectives: _selectedObjectives));
  }

  void _onPressedObjectiveItem(PickerItem item, bool isSelected) {
    final objective = _objectives.firstWhere((e) => e.name == item.name);
    if (isSelected) {
      setState(() {
        _selectedObjectives = (_selectedObjectives..add(objective));
      });
    } else {
      setState(() {
        _selectedObjectives = (_selectedObjectives..remove(objective));
      });
    }
  }

  void _onPressedInterestItem(PickerItem item, bool isSelected) {
    final interest = _interests.firstWhere((e) => e.name == item.name);
    if (isSelected) {
      setState(() {
        _selectedInterests = (_selectedInterests..add(interest));
      });
    } else {
      setState(() {
        _selectedInterests = (_selectedInterests..remove(interest));
      });
    }
  }
}

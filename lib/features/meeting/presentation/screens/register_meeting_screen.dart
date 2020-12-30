import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/base_dropdown/base_dropdown.dart';
import '../../../../ui/base/base_form_field/base_form_field.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/domain/entity/user_profile_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../signup/presentation/widgets/multiselect_dropdown.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/number_of_meetings_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../bloc/meeting_bloc.dart';
import '../widgets/time_slot_picker.dart';

class RegisterMeetingScreen extends StatefulWidget {
  final MeetingConfig config;
  final UserMeetingPreference preference;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;

  const RegisterMeetingScreen({
    Key key,
    @required this.config,
    @required this.preference,
    @required this.objectives,
    @required this.interests,
  }) : super(key: key);

  @override
  _RegisterMeetingScreenState createState() => _RegisterMeetingScreenState();
}

class _RegisterMeetingScreenState extends State<RegisterMeetingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<NumberOfMeetings> _monthlyMeetingOptions = [
    const NumberOfMeetings(label: "Ask me every week", value: 0),
    const NumberOfMeetings(label: "One meeting per month", value: 1),
    const NumberOfMeetings(label: "Bi-weekly meetings", value: 2),
    const NumberOfMeetings(label: "One meeting every week'", value: 4),
  ];
  List<MeetingObjective> lookingFor;
  List<MeetingObjective> lookingTo;
  NumberOfMeetings _numMeetings;
  List<TimeSlot> _selectedSlots = [];
  List<MeetingObjective> _selectedLookingFor = [];
  List<MeetingObjective> _selectedLookingTo = [];
  List<MeetingInterest> _selectedInterests = [];
  String _introduction = "";
  String _linkedinUrl = "";
  MeetingBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<MeetingBloc>(context);
    _bloc.add(const GetPastMeetingPreferencesStarted());
    _splitObjectives(widget.objectives);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.user;
        final profile = state.profile;
        return BlocConsumer<MeetingBloc, MeetingState>(
          listener: (context, state) {
            if (state is PostMeetingPreferencesLoaded) {
              ExtendedNavigator.of(context).pop();
            } else if (state is PostMeetingPreferenceError) {
              Fluttertoast.showToast(
                msg: state.error as String,
              );
              ExtendedNavigator.of(context).pop();
            } else if (state is MeetingGetPastPreferencesLoaded) {
              final UserMeetingPreference pastPrefs = state.pastPreferences;
              if (pastPrefs != null) {
                final List<TimeSlot> slots = [];
                _selectedInterests = pastPrefs.interests;
                widget.config.availableTimeSlots.forEach((key, value) {
                  for (final slot in value) {
                    if (pastPrefs.timeSlots.contains(slot.pk)) {
                      slots.add(slot);
                    }
                  }
                });
                setState(() {
                  _numMeetings = _monthlyMeetingOptions.firstWhere((element) =>
                      element.value == pastPrefs.numberOfMeetingsPerMonth);
                  _selectedLookingFor = pastPrefs.objectives
                      .where(
                          (element) => element.type == ObjectiveType.lookingFor)
                      .toList();
                  _selectedLookingTo = pastPrefs.objectives
                      .where(
                          (element) => element.type == ObjectiveType.lookingTo)
                      .toList();
                  _selectedSlots = slots;
                });
              }
            }
          },
          builder: (context, meetingState) {
            return Scaffold(
              appBar: BaseAppBar(),
              body: Column(
                children: [
                  if (meetingState.loading) const LinearProgressIndicator(),
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      child: !meetingState.loading
                          ? _buildForm(context, user, profile)
                          : null,
                    ),
                  ),
                  buildFullWidth(meetingState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildFullWidth(MeetingState state) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          if (!state.loading) {
            submit();
          }
        },
        splashColor: Theme.of(context).splashColor,
        highlightColor: Theme.of(context).highlightColor,
        child: Container(
          height: 48,
          width: double.infinity,
          child: Center(
            child: Text(
              "Register",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline5.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 24,
        );
    final subheadStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          color: Colors.grey[500],
          height: 1.6,
        );
    final startDate = DateTime.parse(widget.config.weekStartDate);
    final dateFormat = DateFormat("dd MMMM");
    final subheadText =
        "Choose preferences for the week of ${dateFormat.format(startDate)}";
    const headerText = "Register for a meeting\n";
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.xl,
        vertical: AppInsets.xl,
      ),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: headerText,
            style: headingStyle,
          ),
          TextSpan(
            text: subheadText,
            style: subheadStyle,
          )
        ]),
      ),
    );
  }

  Widget _buildForm(BuildContext context, User user, UserProfile profile) {
    final linkedinLabel =
        AppLocalizations.of(context).translate("linkedin:placeholder");
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xl,
          vertical: AppInsets.l,
        ),
        child: Column(
          children: [
            BaseFormField(
              label: "Number of meetings this month?",
              child: BaseDropdown<NumberOfMeetings>(
                listItems: _monthlyMeetingOptions,
                labelGetter: (item) => item.label,
                placeholder: "Indicate your preference",
                value: _numMeetings,
                validator: (value) =>
                    value == null ? "Please select number of meetings" : null,
                onChanged: (value) {
                  setState(() {
                    _numMeetings = value;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "What are you looking to achieve?",
              child: MultiSelectDropdownFormField<MeetingObjective>(
                items: lookingFor,
                labelGetter: (item) => item.name,
                label: "Pick atleast two",
                initialValue: _selectedLookingFor,
                validator: (value) {
                  if (value.length < 2) {
                    return "Please select two objectives";
                  }
                  return null;
                },
                onChangeItems: (items) {
                  setState(() {
                    _selectedLookingFor = items;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "How can you help your connects?",
              child: MultiSelectDropdownFormField<MeetingObjective>(
                items: lookingTo,
                labelGetter: (item) => item.name,
                label: "Pick atleast two",
                initialValue: _selectedLookingTo,
                validator: (value) {
                  if (value.length < 2) {
                    return "Please select two objectives";
                  }
                  return null;
                },
                onChangeItems: (items) {
                  setState(() {
                    _selectedLookingTo = items;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "Who would you like to meet?",
              child: MultiSelectDropdownFormField<MeetingInterest>(
                items: widget.interests,
                labelGetter: (item) => item.name,
                label: "Pick atleast two",
                initialValue: _selectedInterests,
                validator: (value) {
                  if (value.length < 2) {
                    return "Please select two objectives";
                  }
                  return null;
                },
                onChangeItems: (items) {
                  setState(() {
                    _selectedInterests = items;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "Available times?",
              child: TimeSlotFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please select two time slots";
                  } else if (value.length < 2) {
                    return "Please select atleast two time slots";
                  }
                  return null;
                },
                initialValue: _selectedSlots,
                slots: widget.config.availableTimeSlots,
                onChange: (slots) {
                  setState(() {
                    _selectedSlots = slots;
                  });
                },
              ),
            ),
            if (user.linkedinUrl == null && profile.linkedinUrl == null)
              BaseFormField(
                label: linkedinLabel,
                child: BaseFormInput(
                  autovalidate: false,
                  label: linkedinLabel,
                  validator: (value) =>
                      value.isEmpty ? "This field is required" : null,
                  onChanged: (value) {
                    setState(() {
                      _linkedinUrl = value;
                    });
                  },
                ),
              ),
            if (profile != null && profile.introduction == null)
              BaseFormField(
                label: "Your Introductions",
                child: BaseFormInput(
                  autovalidate: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  minLines: 4,
                  validator: (value) =>
                      value.isEmpty ? "Please provide an introduction" : null,
                  label: "How would you like to be introduced?",
                  onChanged: (value) {
                    setState(() {
                      _introduction = value;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _splitObjectives(List<MeetingObjective> objectives) {
    if (objectives.isNotEmpty) {
      final List<MeetingObjective> lookingForObj = objectives
          .where((element) => element.type == ObjectiveType.lookingFor)
          .toList();
      final List<MeetingObjective> lookingToObj = objectives
          .where((element) => element.type == ObjectiveType.lookingTo)
          .toList();
      setState(() {
        lookingFor = lookingForObj;
        lookingTo = lookingToObj;
      });
    }
  }

  void submit() {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _bloc.add(PostMeetingPreferencesStarted(
        config: widget.config,
        interests: _selectedInterests,
        objectives: [..._selectedLookingFor, ..._selectedLookingTo],
        timeSlots: _selectedSlots,
        numberOfMeetings: _numMeetings,
      ));
    }
  }
}

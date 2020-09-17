part of 'register_meet.dart';

class RegisterForm extends StatefulWidget {
  final MeetingConfig meeting;
  final UserMeetingPreference preference;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;

  const RegisterForm({
    Key key,
    @required this.meeting,
    @required this.preference,
    @required this.objectives,
    @required this.interests,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _numMeetings;
  MeetingObjective _objective;
  List<TimeSlot> _selectedSlots = [];
  List<MeetingInterest> _selectedInterests = [];
  String _introduction;
  String _linkedinUrl;
  MeetingBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<MeetingBloc>(context);
    if (widget.preference.pk != null) {
      _intitalizeFormValues();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(RegisterForm oldWidget) {
    if (widget.preference.pk != null &&
        widget.preference != oldWidget.preference) {
      _intitalizeFormValues();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _intitalizeFormValues() {
    setState(() {
      _numMeetings = widget.preference.numberOfMeetings;
      _objective = widget.objectives
          .firstWhere((element) => element.key == widget.preference.objective);
      _selectedSlots = widget.meeting.availableTimeSlots.entries.fold([],
          (previousValue, element) {
        for (final timeslot in element.value) {
          if (widget.preference.timeSlots.contains(timeslot.pk)) {
            previousValue.add(timeslot);
          }
        }
        return previousValue;
      });
      _selectedInterests = widget.interests.fold([], (previousValue, element) {
        if (widget.preference.interests.contains(element.pk)) {
          previousValue.add(element);
        }
        return previousValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            const SizedBox(height: AppInsets.xxl),
            _buildMeetingForm(context, state)
          ],
        );
      },
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
    final startDate = DateTime.parse(widget.meeting.weekStartDate);
    final dateFormat = DateFormat("dd MMMM");
    final subheadText =
        "Choose preferences for the week of ${dateFormat.format(startDate)}";
    final headerText = widget.preference.pk == null
        ? "Register for meeting\n"
        : "Update meeting preferences\n";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
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

  Widget _buildMeetingForm(BuildContext context, AuthState state) {
    final user = state.user;
    final profile = state.profile;
    final linkedinLabel =
        AppLocalizations.of(context).translate("linkedin:placeholder");
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseFormField(
              label: "How many meetings?",
              child: BaseDropdown<int>(
                listItems: const [1, 2],
                labelGetter: (item) => item.toString(),
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
              label: "Available times?",
              child: TimeSlotFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please select one time slot";
                  }
                  return null;
                },
                initialValue: _selectedSlots,
                slots: widget.meeting.availableTimeSlots,
                onChange: (slots) {
                  setState(() {
                    _selectedSlots = slots;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "Your Objective",
              child: BaseDropdown<MeetingObjective>(
                value: _objective,
                listItems: widget.objectives,
                labelGetter: (item) => item.label,
                placeholder: "Select Objective",
                validator: (value) {
                  if (value == null) {
                    return "Please select one objective";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _objective = value;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "Your Preferences",
              child: MultiSelectDropdownFormField<MeetingInterest>(
                items: widget.interests,
                labelGetter: (item) => item.name,
                label: "I am keen to network with",
                initialValue: _selectedInterests,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please select an interest";
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
            if (user.linkedinUrl == null)
              BaseFormField(
                label: linkedinLabel,
                child: BaseFormInput(
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
            const SizedBox(height: 72)
          ],
        ),
      ),
    );
  }

  void submit() {
    final isValid = _formKey.currentState.validate();
    final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
    print(_selectedSlots.map((e) => e.pk).toList());
    if (isValid) {
      if (widget.preference.pk == null) {
        _bloc.add(PostMeetingPreferencesStarted(
          meeting: widget.meeting.pk,
          interests: _selectedInterests.map((e) => e.pk).toList(),
          numberOfMeetings: _numMeetings,
          timeSlots: _selectedSlots.map((e) => e.pk).toList(),
          objective: _objective.key,
        ));
      } else {
        _bloc.add(PatchMeetingPreferencesStarted(
          meetingPref: widget.preference.pk,
          meeting: widget.meeting.pk,
          interests: _selectedInterests.map((e) => e.pk).toList(),
          numberOfMeetings: _numMeetings,
          timeSlots: _selectedSlots.map((e) => e.pk).toList(),
          objective: _objective.key,
        ));
      }
      _navigator.currentState.pop();
    }
  }
}

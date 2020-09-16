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
  int _num_meetings;
  MeetingObjective _objective;
  List<TimeSlot> _selectedSlots = [];
  List<MeetingInterest> _selectedInterests = [];

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "Register for meeting\n",
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
                value: _num_meetings,
                onChanged: (value) {
                  setState(() {
                    _num_meetings = value;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "Available times?",
              child: TimeSlotPicker(
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
                onChanged: (value) {
                  setState(() {
                    _objective = value;
                  });
                },
              ),
            ),
            BaseFormField(
              label: "Your Preferences",
              child: MultiSelectDropdown<MeetingInterest>(
                items: widget.interests,
                labelGetter: (item) => item.name,
                label: "I am keen to network with",
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
                ),
              ),
            if (profile != null && profile.introduction == null)
              BaseFormField(
                label: "Your Introductions",
                child: BaseFormInput(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  minLines: 4,
                  label: "How would you like to be introduced?",
                ),
              ),
            const SizedBox(height: 72)
          ],
        ),
      ),
    );
  }
}

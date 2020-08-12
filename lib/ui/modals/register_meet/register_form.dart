part of 'register_meet.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  MeetingObjective _selectedObjective;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeetingBloc, MeetingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildFormHeader(context, state),
              const SizedBox(height: AppInsets.xl),
              _buildForm(context, state)
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormHeader(BuildContext context, MeetingState state) {
    final dateFormatter = DateFormat('MMMM d');
    final date = DateTime.parse(state.meeting.weekStartDate);
    final title =
        AppLocalizations.of(context).translate('meeting:register_title');
    final subtitle = state.userPrefs != null
        ? 'Update your preferences for the week of ${dateFormatter.format(date)}'
        : 'Choose your preferences for the week of ${dateFormatter.format(date)}';
    return TabHeader(
      heading: title,
      subHeading: subtitle,
    );
  }

  void _onChangeObjective(MeetingObjective value) =>
      setState(() => _selectedObjective = value);

  Widget _buildForm(BuildContext context, MeetingState state) {
    final labelStyle = Theme.of(context).textTheme.subtitle2;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Your Objective', style: labelStyle),
          const SizedBox(height: AppInsets.med),
          BaseDropdown<MeetingObjective>(
            value: _selectedObjective,
            onChanged: _onChangeObjective,
            labelGetter: (item) => item.label,
            listItems: state.objectives,
          )
        ],
      ),
    );
  }
}

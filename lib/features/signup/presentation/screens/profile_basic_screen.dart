import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_basic/profile_basic_bloc.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

class ProfileBasicScreen extends StatefulWidget {
  final bool editMode;

  const ProfileBasicScreen({
    Key key,
    @PathParam("editMode") this.editMode,
  }) : super(key: key);

  @override
  _ProfileBasicScreenState createState() => _ProfileBasicScreenState();
}

class _ProfileBasicScreenState extends State<ProfileBasicScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  ProfileBasicBloc _bloc;

  @override
  void initState() {
    final user = BlocProvider.of<AuthBloc>(context).state.user;

    _bloc = KiwiContainer().resolve<ProfileBasicBloc>();

    if (user.name != null) {
      final name = user.name.split(' ');
      _firstNameController.text = name.first;
      _lastNameController.text = name.last;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String heading = 'Lets get started';

    final next = AppLocalizations.of(context).translate("next");
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<ProfileBasicBloc, ProfileBasicState>(
        listener: _profileSetupBlocListener,
        builder: (context, state) {
          return Scaffold(
            appBar: BaseAppBar(),
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeader(title: heading),
                    _buildProfileForm(context),
                    const Spacer(),
                    ProfileFooter(onSave: _onPressedSubmit)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _bloc.close();
    super.dispose();
  }

  Widget _buildProfileForm(BuildContext context) {
    final firstnameLabel = 'Your first name';
    final lastnameLabel = 'Your last name';
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xxl, vertical: AppInsets.l),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            BaseFormInput(
              controller: _firstNameController,
              autovalidate: false,
              label: firstnameLabel,
              validator: (value) =>
                  value.isEmpty ? "This field is required" : null,
            ),
            const SizedBox(height: AppInsets.xxl),
            BaseFormInput(
              controller: _lastNameController,
              autovalidate: false,
              label: lastnameLabel,
              validator: (value) =>
                  value.isEmpty ? "This field is required" : null,
            ),
            const SizedBox(height: AppInsets.xxl),
          ],
        ),
      ),
    );
  }

  void _goToNextScreen() {
    ExtendedNavigator.of(context)
        .push(Routes.profileTagsScreen(editMode: widget.editMode));
  }

  void _onPressedSubmit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      final name = '${_firstNameController.text} ${_lastNameController.text}';
      _bloc.add(PostProfileBasicRequestStarted(name: name));
    }
  }

  void _profileSetupBlocListener(
      BuildContext context, ProfileBasicState state) {
    if (state is PatchProfileBasicRequestLoaded) {
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserUpdateRecieved(user: state.user));
      _goToNextScreen();
    }
  }
}

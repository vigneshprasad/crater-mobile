import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/domain/entity/user_tag_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_setup/profile_setup_bloc.dart';
import '../widgets/multiselect_dropdown.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _linkedInController = TextEditingController();
  ProfileSetupBloc _bloc;
  String _photoUrl;
  List<UserTag> _tags;
  List<UserTag> _selectedTags;
  String _name;

  @override
  void initState() {
    _bloc = KiwiContainer().resolve<ProfileSetupBloc>()
      ..add(const GetUserTagsRequestStarted());
    _name = BlocProvider.of<AuthBloc>(context).state.user.name;
    if (_name.trim().isNotEmpty) {
      final letter = _name.substring(0, 1).toLowerCase();
      _photoUrl = AppConstants.defaultAvatar[letter];
    } else {
      _photoUrl = AppConstants.defaultAvatar["default"];
    }

    _tags = [];
    _selectedTags = [];
    super.initState();
  }

  @override
  void dispose() {
    _linkedInController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;
        final headingStyle = Theme.of(context).textTheme.headline5.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            );
        final heading =
            "Thanks, ${user.name}.\nHow do we introduce you to others?";
        final next = AppLocalizations.of(context).translate("next");
        return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
            listener: _profileSetupBlocListener,
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Center(
                              child: Text(
                                heading,
                                style: headingStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Center(
                              child: _buildPhotoPicker(context),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: _buildProfileForm(context, user),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppInsets.xxl),
                                  child: BaseLargeButton(
                                    text: next,
                                    onPressed: _onPressedSubmit,
                                  ),
                                ),
                              )
                            ],
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

  Widget _buildPhotoPicker(BuildContext context) {
    const imageRadius = 56.00;
    return CircleAvatar(
      backgroundImage: NetworkImage(_photoUrl),
      radius: imageRadius,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey[200].withAlpha(20),
          borderRadius: BorderRadius.circular(imageRadius),
          onTap: () {},
        ),
      ),
    );
  }

  void _profileSetupBlocListener(
      BuildContext context, ProfileSetupState state) {
    if (state is ProfileUserTagsRequestLoaded) {
      setState(() {
        _tags = state.tags;
      });
    } else if (state is PostUserProfileRequestLoaded) {
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserProfileUpdateRecieved(profile: state.profile));
      ExtendedNavigator.of(context).popAndPush(Routes.phoneVerificationScreen);
    }
  }

  Widget _buildProfileForm(BuildContext context, User user) {
    final linkedinLabel =
        AppLocalizations.of(context).translate("linkedin:placeholder");
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xxl, vertical: AppInsets.l),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            BaseFormInput(
              controller: _linkedInController,
              autovalidate: false,
              label: linkedinLabel,
              validator: (value) =>
                  value.isEmpty ? "This field is required" : null,
            ),
            const SizedBox(height: AppInsets.xxl),
            _buildTagPicker(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildTagPicker(BuildContext context, User user) {
    final label = AppLocalizations.of(context).translate("tags:placeholder");
    return MultiSelectDropdownFormField<UserTag>(
      items: _tags,
      labelGetter: (item) => item.name,
      maxLength: 2,
      onChangeItems: _onChangeSelectedTags,
      label: label,
    );
  }

  void _onChangeSelectedTags(List<UserTag> selected) {
    setState(() {
      _selectedTags = selected;
    });
  }

  void _onPressedSubmit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _bloc.add(PostProfileRequestStarted(
        photoUrl: _photoUrl,
        linkedinUrl: _linkedInController.text,
        name: _name,
        userTags: _selectedTags,
      ));
    }
  }
}

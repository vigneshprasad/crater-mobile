import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/features/social_auth/domain/usecase/get_social_auth_token.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../auth/domain/entity/user_tag_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../bloc/profile_tags/profile_tags_bloc.dart';
import '../widgets/objectives_picker.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

class ProfileTagsScreen extends StatefulWidget {
  final bool editMode;

  const ProfileTagsScreen({
    Key? key,
    @PathParam("editMode") required this.editMode,
  }) : super(key: key);

  @override
  _ProfileTagsScreenState createState() => _ProfileTagsScreenState();
}

class _ProfileTagsScreenState extends State<ProfileTagsScreen> {
  late ProfileTagsBloc _bloc;
  late List<UserTag> tags;
  late List<UserTag> selectedTags;
  late List<PickerItem> items;
  bool allowSkip = false;

  @override
  void initState() {
    tags = [];
    _bloc = KiwiContainer().resolve<ProfileTagsBloc>()
      ..add(const GetProfileTagsRequestStarted());

    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    selectedTags = user?.tagList ?? [];

    if (widget.editMode == false) {
      SharedPreferences.getInstance().then((prefs) {
        final provider = prefs.getString('AuthProvider');
        if (provider == SocialAuthProviders.apple.toString()) {
          setState(() {
            allowSkip = true;
          });
        }
      });
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
    items = tags
        .map((e) => PickerItem(
              name: e.name,
              selected: selectedTags.contains(e),
            ))
        .toList();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        const heading = 'Currently you are a';

        return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileTagsBloc, ProfileTagsState>(
            listener: _blocListener,
            builder: (context, state) {
              return Scaffold(
                appBar: BaseAppBar(),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ProfileHeader(title: heading),
                              if (tags.isNotEmpty)
                                ObjectivesPicker(
                                  objectives: items,
                                  onPressedItem: _onPressedObjectiveItem,
                                ),
                              const SizedBox(height: AppInsets.xxl),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ProfileFooter(
                      onSave: _onPressSubmit,
                      onSkip: allowSkip ? goToNextScreen : null,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _blocListener(BuildContext context, ProfileTagsState state) {
    if (state is ProfileTagsRequestLoaded) {
      setState(() {
        tags = state.tags;
      });
    } else if (state is PostProfileTagsRequestLoaded) {
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserProfileUpdateRecieved(profile: state.user));
      goToNextScreen();
    }
  }

  void goToNextScreen() {
    AutoRouter.of(context).push(const ProfileExtraInfoScreenRoute());
  }

  void _onPressSubmit() {
    if (selectedTags.isEmpty) {
      return;
    }
    _bloc.add(PostProfileTagsRequestStarted(
        tagIds: selectedTags.map((e) => e.pk!).toList()));
  }

  void _onPressedObjectiveItem(PickerItem item, bool isSelected) {
    final tag = tags.firstWhere((element) => element.name == item.name);
    if (isSelected) {
      selectedTags = [tag];
    } else {
      selectedTags = [];
    }

    setState(() {
      items = tags
          .map((e) => PickerItem(
                name: e.name,
                selected: selectedTags.contains(e),
              ))
          .toList();
    });
  }
}

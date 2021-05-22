import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../auth/domain/entity/user_tag_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_tags/profile_tags_bloc.dart';
import '../widgets/objectives_picker.dart';
import '../widgets/profile_footer.dart';
import '../widgets/profile_header.dart';

class ProfileTagsScreen extends StatefulWidget {
  final bool editMode;

  const ProfileTagsScreen({
    Key key,
    @PathParam("editMode") this.editMode,
  }) : super(key: key);

  @override
  _ProfileTagsScreenState createState() => _ProfileTagsScreenState();
}

class _ProfileTagsScreenState extends State<ProfileTagsScreen> {
  ProfileTagsBloc _bloc;
  List<UserTag> tags;
  List<UserTag> selectedTags;

  @override
  void initState() {
    tags = [];
    _bloc = KiwiContainer().resolve<ProfileTagsBloc>()
      ..add(const GetProfileTagsRequestStarted());

    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    selectedTags = user?.tagList ?? [];
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
        String heading = 'A bit about your present';

        return BlocProvider.value(
          value: _bloc,
          child: BlocConsumer<ProfileTagsBloc, ProfileTagsState>(
            listener: _blocListener,
            builder: (context, state) {
              return Scaffold(
                appBar: BaseAppBar(),
                body: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(title: heading),
                        if (tags.isNotEmpty)
                          ObjectivesPicker(
                            objectives: tags
                                .map((e) => PickerItem(
                                      name: e.name,
                                      selected: selectedTags.contains(e),
                                    ))
                                .toList(),
                            onPressedItem: _onPressedObjectiveItem,
                          ),
                        const SizedBox(height: AppInsets.xxl),
                        ProfileFooter(onSave: _onPressSubmit),
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

  void _blocListener(BuildContext context, ProfileTagsState state) {
    if (state is ProfileTagsRequestLoaded) {
      setState(() {
        tags = state.tags;
      });
    } else if (state is PostProfileTagsRequestLoaded) {
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserProfileUpdateRecieved(profile: state.user));
      ExtendedNavigator.of(context)
          .push(Routes.profileIntroScreen(editMode: widget.editMode));
    }
  }

  void _onPressSubmit() {
    if (selectedTags.isEmpty) {
      return;
    }
    _bloc.add(PostProfileTagsRequestStarted(
        tagIds: selectedTags.map((e) => e.pk).toList()));
  }

  void _onPressedObjectiveItem(PickerItem item, bool isSelected) {
    final tag = tags.firstWhere((element) => element.name == item.name);
    if (isSelected) {
      setState(() {
        selectedTags = (selectedTags..add(tag));
      });
    } else {
      setState(() {
        selectedTags = (selectedTags..remove(tag));
      });
    }
  }
}

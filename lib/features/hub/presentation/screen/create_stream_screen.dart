import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_multi_select_dropdown/base_multi_select_dropdown.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_request_entity.dart';
import 'package:worknetwork/features/hub/data/repository/cover_image_repository.dart';
import 'package:worknetwork/features/hub/presentation/screen/create_stream_screen_state.dart';
import 'package:worknetwork/features/hub/presentation/widgets/stream_cover_picker.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../routes.gr.dart';

class CreateStreamScreen extends HookWidget {
  CreateStreamScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? base64Image;
  String? startDate;

  List<CategoriesDetailList> categories = [];

  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    final createStreamState = useProvider(createStreamProvider(0));

    final _titleController = useTextEditingController();
    final _coHostController = useTextEditingController();
    final _descriptionController = useTextEditingController();
    final _rtmpController = useTextEditingController();

    _coHostController.text = 'COMING SOON';

    const borderRadius = BorderRadius.all(
      Radius.circular(AppBorderRadius.textInput),
    );

    final coverImageUrl = useState<Image?>(null);
    final scrollController = useScrollController();

    Future _generateImage() async {
      final isValid = _formKey.currentState?.validate();

      final topic = _titleController.text;
      String? avtarUrl;
      String _name;

      final user = BlocProvider.of<AuthBloc>(context).state.user;
      if (user != null) {
        avtarUrl = user.photo;
        _name = user.name ?? '';
      } else {
        avtarUrl = null;
        _name = '';
      }

      if (avtarUrl == null) {
        if (_name.trim().isNotEmpty) {
          final letter = _name.substring(0, 1).toLowerCase();
          avtarUrl = AppConstants.defaultAvatar[letter];
        } else {
          avtarUrl = AppConstants.defaultAvatar["default"];
        }
      }

      if (topic.isNotEmpty && avtarUrl != null) {
        overlayEntry = buildLoaderOverlay();
        Overlay.of(context)?.insert(overlayEntry!);

        final response = await context
            .read(coverImageRepositoryProvider)
            .postGenerateImage(topic, avtarUrl);

        response.fold((failure) {
          overlayEntry?.remove();
          Fluttertoast.showToast(msg: failure.message!);
        }, (imageUrl) {
          overlayEntry?.remove();
          base64Image = imageUrl;
          final decodedBytes = base64.decode(imageUrl.split(',').last);
          final image = Image.memory(
            decodedBytes,
            fit: BoxFit.cover,
          );
          coverImageUrl.value = image;
        });
      }
    }

    Future<void> _onChoosePhoto(File file) async {
      final bytes = file.readAsBytesSync();
      base64Image = 'data:image/jpeg;base64,' + base64Encode(bytes);
      coverImageUrl.value = null;
    }

    Future<void> _onSubmitPressed() async {
      final isValid = _formKey.currentState?.validate() ?? false;

      if (base64Image == null ||
          startDate == null ||
          categories.isEmpty ||
          !isValid) {
        Fluttertoast.showToast(msg: 'Fill all required details');
        return;
      }

      overlayEntry = buildLoaderOverlay();
      Overlay.of(context)?.insert(overlayEntry!);

      final categoryIds = categories.map((e) => e.pk!);
      final request = WebinarRequest(
        title: _titleController.text,
        categories: categoryIds.toList(),
        coverImage: base64Image!,
        start: startDate!,
        rtmpLink: _rtmpController.text,
        description: _descriptionController.text,
      );

      final response = await context
          .read(conversationRepositoryProvider)
          .postWebinar(request);

      response.fold((failure) {
        overlayEntry?.remove();
        Fluttertoast.showToast(msg: failure.message!);
      }, (webinar) {
        overlayEntry?.remove();
        _formKey.currentState?.reset();

        base64Image = null;
        coverImageUrl.value = null;
        _titleController.text = '';
        _descriptionController.text = '';
        categories = [];
        startDate = null;

        AutoRouter.of(context).push(ConversationScreenRoute(id: webinar.id));
      });
    }

    return createStreamState.when(
      error: (error, stack) => Container(),
      loading: () => Container(),
      data: (state) => SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          height: 1200,
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: AppPadding.sm),
                    BaseFormInput(
                      controller: _titleController,
                      label: '',
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppPadding.med),
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: AppPadding.sm),
                    BaseMultiSelectDropdownFormField<CategoriesDetailList>(
                        label: 'PICK CATEGORIES',
                        maxLength: 3,
                        items: state.categories,
                        labelGetter: (lbl) => lbl.name ?? '',
                        validator: (value) {
                          return (value == null || value.isEmpty)
                              ? 'Select a value'
                              : null;
                        },
                        onChanged: (value) {
                          categories = value;
                        }),
                    const SizedBox(height: AppPadding.med),
                    // Text(
                    //   'Co-host',
                    //   style: Theme.of(context).textTheme.subtitle2,
                    //   textAlign: TextAlign.start,
                    // ),
                    // const SizedBox(height: AppPadding.sm),
                    // BaseFormInput(
                    //   controller: _coHostController,
                    //   label: 'COMING SOON',
                    //   enabled: false,
                    //   maxLines: 1,
                    //   validator: (text) {
                    //     if (text == null || text.isEmpty) return null;
                    //     return null;
                    //   },
                    // ),
                    // const SizedBox(height: AppPadding.med),
                    Text(
                      'Date',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: AppPadding.sm),
                    DateTimePicker(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: borderRadius,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: borderRadius,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: borderRadius,
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                          filled: true,
                          hintText: '',
                          hintStyle:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                          labelStyle: const TextStyle(fontSize: 16),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: AppInsets.med,
                            horizontal: AppInsets.l,
                          )),
                      type: DateTimePickerType.dateTime,
                      initialValue: '',
                      initialDate: DateTime.now().add(const Duration(days: 2)),
                      firstDate: DateTime.now().add(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                      dateLabelText: 'Date',
                      onChanged: (val) {
                        startDate = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Date is required';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        startDate = val;
                      },
                    ),
                    const SizedBox(height: AppPadding.med),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: AppPadding.sm),
                    BaseFormInput(
                      controller: _descriptionController,
                      autovalidate: false,
                      minLines: 10,
                      label: '',
                      validator: (value) => null,
                    ),
                    const SizedBox(height: AppPadding.med),
                    Text(
                      'Cover Photo',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Generate Image or Upload an image from your photo gallery.',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: AppPadding.sm),
                    StreamCoverPicker(
                      image: coverImageUrl.value,
                      onGenerateImage: _generateImage,
                      onChoosePhoto: _onChoosePhoto,
                    ),
                    const SizedBox(height: AppPadding.med),
                    Text(
                      'RTMP Link',
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Stream to Youtube, Twitter, LinkedIn or Facebook',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: AppPadding.sm),
                    BaseFormInput(
                      controller: _rtmpController,
                      autovalidate: false,
                      minLines: 3,
                      label: '',
                      validator: (value) => null,
                    ),
                    const Spacer(),
                    Center(
                      child: BaseLargeButton(
                        onPressed: _onSubmitPressed,
                        text: "Submit",
                      ),
                    ),
                    const SizedBox(height: AppInsets.xxl),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

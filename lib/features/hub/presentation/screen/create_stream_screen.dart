import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/hub/presentation/screen/create_stream_screen_state.dart';
import 'package:worknetwork/features/hub/presentation/widgets/stream_cover_picker.dart';
import 'package:worknetwork/ui/base/base_dropdown/base_dropdown.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class CreateStreamScreen extends HookWidget {
  CreateStreamScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final createStreamState = useProvider(createStreamProvider(0));

    _passwordController.text = 'COMING SOON';
    
    const borderRadius = BorderRadius.all(
      Radius.circular(AppBorderRadius.textInput),
    );

    return createStreamState.when(
      error: (error, stack)=>Container(),
      loading: () => Container(),
      data: (state) => SingleChildScrollView(
      child: SizedBox(
        height: 1200,
        child: Form(
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
                    controller: _emailController,
                    label: '',
                    validator: (text) {
                      if (text == null || text.isEmpty) return null;
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
                  BaseDropdown<CategoriesDetailList>(
                      placeholder: 'PICK CATEGORIES',
                      listItems: state.categories,
                      labelGetter: (lbl) => lbl.name ?? '',
                      validator: (value) {
                        return value == null ? 'Select a value' : null;
                      },
                      onChanged: (value) {}),
                  const SizedBox(height: AppPadding.med),
                  Text(
                    'Co-host',
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: AppPadding.sm),
                  BaseFormInput(
                    controller: _passwordController,
                    label: 'COMING SOON',
                    enabled: false,
                    maxLines: 1,
                    validator: (text) {
                      if (text == null || text.isEmpty) return null;
                      return null;
                    },
                  ),
                  const SizedBox(height: AppPadding.med),
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
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    dateLabelText: 'Date',
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                  const SizedBox(height: AppPadding.med),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: AppPadding.sm),
                  BaseFormInput(
                    controller: _bioController,
                    autovalidate: false,
                    minLines: 10,
                    label: '',
                    validator: (value) => value == null || value.isEmpty
                        ? "This field is required"
                        : null,
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
                  StreamCoverPicker(),
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
                    controller: _bioController,
                    autovalidate: false,
                    minLines: 3,
                    label: '',
                    validator: (value) => value == null || value.isEmpty
                        ? "This field is required"
                        : null,
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
    ),);
  }

  void _onSubmitPressed() {}
}
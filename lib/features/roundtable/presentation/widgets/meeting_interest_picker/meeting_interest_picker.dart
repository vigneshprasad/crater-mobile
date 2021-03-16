import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../ui/base/base_error_text/base_error_text.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';

const kIconSize = 74.00;
const kSelectorSize = 84.00;
const kRowLength = 3;

class MeetingInterestPicker extends HookWidget {
  final List<MeetingInterest> options;
  final List<MeetingInterest> initialValue;
  final ValueChanged<List<MeetingInterest>> onValueChanged;

  const MeetingInterestPicker({
    Key key,
    @required this.options,
    @required this.onValueChanged,
    this.initialValue = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selected = useState(initialValue);
    final rows = _getTableRows(options);
    return Table(
      children: rows
          .map(
            (row) => TableRow(
              children: row
                  .map(
                    (interest) => interest != null
                        ? _InterestItem(
                            interest: interest,
                            selected: _selected.value.contains(interest),
                            onValuePressed: (value) {
                              final updated = [..._selected.value];
                              if (_selected.value.contains(value)) {
                                updated.remove(value);
                              } else {
                                updated.add(value);
                              }
                              _selected.value = updated;
                              onValueChanged(_selected.value);
                            },
                          )
                        : Container(),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  List<List<MeetingInterest>> _getTableRows(List<MeetingInterest> options) {
    final List<List<MeetingInterest>> rows = options.fold(
      [[]],
      (list, interest) => list.last.length == kRowLength
          ? (list..add([interest]))
          : (list..last.add(interest)),
    );

    rows.map((row) {
      if (row.length < 3) {
        final filler = List(3 - row.length);
        row.addAll(filler.map((e) => null));
      }
    }).toList();

    return rows;
  }
}

class _InterestItem extends StatelessWidget {
  final MeetingInterest interest;
  final bool selected;
  final ValueChanged<MeetingInterest> onValuePressed;

  const _InterestItem({
    Key key,
    @required this.interest,
    @required this.selected,
    @required this.onValuePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final labelStyle = Theme.of(context).textTheme.bodyText2;
    return Padding(
      padding: const EdgeInsets.all(AppInsets.med),
      child: GestureDetector(
        onTap: () {
          onValuePressed(interest);
        },
        child: Column(
          children: [
            BaseNetworkImage(
              imageUrl: interest.icon,
              defaultImage: AppImageAssets.defaultAvatar,
              imagebuilder: (context, imageProvider) {
                return Container(
                  height: kSelectorSize,
                  width: kSelectorSize,
                  padding: const EdgeInsets.all(AppInsets.sm),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(color: primaryColor, width: 3)
                        : null,
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppInsets.sm),
            Text(
              interest.name,
              style: labelStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class FormMeetingInterestPicker extends FormField<List<MeetingInterest>> {
  final List<MeetingInterest> options;

  FormMeetingInterestPicker({
    FormFieldSetter<List<MeetingInterest>> onSaved,
    FormFieldValidator<List<MeetingInterest>> validator,
    List<MeetingInterest> initialValue = const [],
    AutovalidateMode autovalidateMode = AutovalidateMode.always,
    @required this.options,
  }) : super(
          onSaved: onSaved,
          autovalidateMode: autovalidateMode,
          validator: validator,
          initialValue: initialValue,
          builder: (state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MeetingInterestPicker(
                  options: options,
                  onValueChanged: (value) {
                    state.didChange(value);
                    state.save();
                  },
                ),
                if (state.hasError) BaseErrorText(text: state.errorText),
              ],
            );
          },
        );
}

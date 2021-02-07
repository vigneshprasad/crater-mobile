import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/ui/base/base_input/base_input.dart';

class EditableTextField extends HookWidget {
  final String text;
  final bool editable;
  final ValueChanged<String> onValueChanged;

  const EditableTextField({
    @required this.text,
    this.editable = false,
    this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final editMode = useState(false);
    final descriptionStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );
    final _textInputFocus = useFocusNode();
    final _textController = useTextEditingController();
    useEffect(() {
      _textController.text = text;
      return;
    });
    return Row(
      children: [
        if (editMode.value)
          Flexible(
            child: BaseInput(
              maxLines: null,
              focusNode: _textInputFocus,
              controller: _textController,
              label: null,
            ),
          ),
        if (!editMode.value)
          Flexible(
            child: Text(
              text,
              style: descriptionStyle,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (editable) const SizedBox(width: AppInsets.med),
        if (editable)
          _ToggleButton(
            enabled: editMode.value,
            onToggle: () {
              if (editMode.value) {
                if (onValueChanged != null) {
                  onValueChanged(_textController.text);
                }
              }
              editMode.value = !editMode.value;
              if (editMode.value) {
                _textInputFocus.requestFocus();
              }
            },
          ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onToggle;

  const _ToggleButton({
    Key key,
    @required this.enabled,
    @required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final icon = enabled ? Icons.check : Icons.edit;
    final iconColor = enabled ? Colors.white : Colors.grey[700];
    final backgroundColor = enabled ? primaryColor : Colors.grey[300];
    return Material(
      shape: const CircleBorder(),
      color: backgroundColor,
      child: InkWell(
        onTap: onToggle,
        customBorder: const CircleBorder(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
    );
  }
}

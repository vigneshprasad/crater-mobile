import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libphonenumber/libphonenumber.dart' as libphone;
import 'package:phone_number/phone_number.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/ui/base/phone_number_input/models.dart';
import 'package:worknetwork/utils/generate_flag_unicode.dart';

typedef OnValidCallback = void Function(bool isValid);
typedef OnChangeCallback = void Function(String value);

class PhoneNumberInput extends StatefulWidget {
  final String label;
  final bool autoValidate;
  final OnValidCallback? onValidChange;
  final String? initalCountry;
  final OnChangeCallback? onChange;
  final Color? backgroundColor;

  const PhoneNumberInput({
    Key? key,
    this.label = "Phone Number",
    this.autoValidate = true,
    this.onValidChange,
    this.initalCountry,
    this.onChange,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final PhoneNumberUtil plugin = PhoneNumberUtil();
  final FocusNode _inputFocus = FocusNode();
  final TextEditingController _controller = TextEditingController();
  late List<Country> _countries;
  Country? _selectedCountry;
  late bool _isFocused;
  late bool _isValid;

  @override
  void initState() {
    _countries = [];
    _isFocused = false;
    _isValid = false;
    _initialzeWidget();
    _controller.addListener(_textEditingListener);
    super.initState();
  }

  Future<void> _initialzeWidget() async {
    final countries = await _getCountriesList();

    _inputFocus.addListener(() {
      setState(() {
        _isFocused = _inputFocus.hasFocus;
      });
    });
    setState(() {
      _countries = countries;
    });

    if (widget.initalCountry != null) {
      final initalCountry =
          countries.where((element) => element.isoCode == "IN").first;
      setState(() {
        _selectedCountry = initalCountry;
      });
    }
  }

  Future<List<Country>> _getCountriesList() async {
    final res = await plugin.allSupportedRegions();
    return res
        .map(
          (e) => Country(
            countryCode: e.prefix,
            isoCode: e.code,
            flagCode: generateFlagEmojiUnicode(e.code),
          ),
        )
        .toList();
  }

  InputDecoration _getInputDecoration() {
    final check = Icon(
      Icons.check_circle_outline,
      color: Colors.green[300],
    );
    return InputDecoration(
      border: InputBorder.none,
      hintText: widget.label,
      suffixIcon: _isValid ? check : null,
    );
  }

  BoxDecoration _getBoxDecoration() {
    final border = _isValid
        ? Border.all(width: 2, color: Colors.green[300]!)
        : _isFocused
            ? Border.all(width: 2, color: Theme.of(context).primaryColor)
            : Border.all(width: 2, color: Colors.transparent);
    return BoxDecoration(
      color: widget.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
      border: border,
      borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
      decoration: _getBoxDecoration(),
      constraints: const BoxConstraints(
        maxHeight: kMinInteractiveDimension,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<Country>(
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
              value: _selectedCountry,
              items: _countries
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        "${e.flagCode} +${e.countryCode}",
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(width: AppInsets.sm),
          const VerticalDivider(
            width: 2,
            endIndent: 8,
            indent: 8,
          ),
          const SizedBox(width: AppInsets.l),
          Flexible(
            child: TextField(
              controller: _controller,
              focusNode: _inputFocus,
              decoration: _getInputDecoration(),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _textEditingListener() {
    if (widget.autoValidate &&
        _controller.text.isNotEmpty &&
        _selectedCountry != null) {
      final parsedPhoneNumberString =
          _controller.text.replaceAll(RegExp(r'[^\d+]'), '');
      final isoCode = _selectedCountry!.isoCode;
      final value = "+${_selectedCountry!.countryCode}$parsedPhoneNumberString";

      widget.onChange?.call(value);

      _validatePhoneNumber(parsedPhoneNumberString, isoCode).then((isValid) {
        if (widget.onValidChange != null) {
          widget.onValidChange!(isValid);
          setState(() {
            _isValid = isValid;
          });
        }
      });
    }
  }

  Future<bool> _validatePhoneNumber(String phoneNumber, String isoCode) async {
    try {
      final isValid = await libphone.PhoneNumberUtil.isValidPhoneNumber(
        phoneNumber: phoneNumber,
        isoCode: isoCode,
      );
      return isValid ?? false;
    } on Exception {
      return false;
    }
  }
}

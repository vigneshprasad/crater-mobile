import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../constants/app_constants.dart';
import '../../../../core/widgets/base/base_network_image/base_network_image.dart';

class StreamCoverPicker extends StatefulWidget {
  final String? photoUrl;
  final Function(File)? onChoosePhoto;
  final Function()? onGenerateImage;
  final Image? image;

  const StreamCoverPicker({
    Key? key,
    this.photoUrl,
    this.image,
    this.onChoosePhoto,
    this.onGenerateImage,
  }) : super(key: key);

  @override
  _StreamCoverPickerState createState() => _StreamCoverPickerState();
}

class _StreamCoverPickerState extends State<StreamCoverPicker> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    const double imageRadius = 56.00;

    final height = MediaQuery.of(context).size.width * 576 / 1024;

    return Column(children: [
      Row(
        children: [
          Positioned(
            bottom: 8,
            left: 8,
            child: BaseLargeButton(
              text: widget.image == null ? 'Generate Image' : 'Randomize Image',
              onPressed: widget.onGenerateImage,
            ),
          ),
          const Spacer(),
          Positioned(
            bottom: 8,
            right: 8,
            child: BaseLargeButton(
              text: 'Upload Image',
              onPressed: _choosePhoto,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        width: double.infinity,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: (widget.image != null)
            ? widget.image
            : (_image != null)
                ? Image(
                    image: Image.file(_image!).image,
                    width: double.infinity,
                    height: height,
                    fit: BoxFit.cover,
                  )
                : Container(),
      ),
    ]);
  }

  Future _choosePhoto() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1024, maxHeight: 576);
    /*
    NOTE: ImagePicker crashes on picking image second time on iOS Simulator.
    https://github.com/flutter/flutter/issues/68283
    */

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
    if (widget.onChoosePhoto != null && _image != null) {
      widget.onChoosePhoto!(_image!);
    }
  }
}

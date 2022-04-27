import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../constants/app_constants.dart';
import '../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../core/widgets/base/base_network_image/base_network_image.dart';

class StreamCoverPicker extends StatefulWidget {
  final String? photoUrl;
  final Function(File)? onChoosePhoto;

  const StreamCoverPicker({Key? key, this.photoUrl, this.onChoosePhoto})
      : super(key: key);

  @override
  _StreamCoverPickerState createState() => _StreamCoverPickerState();
}

class _StreamCoverPickerState extends State<StreamCoverPicker> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    const double imageRadius = 56.00;

    return Stack(children: [
      Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor, borderRadius: BorderRadius.circular(8)),
        child: BaseNetworkImage(
          imageUrl: widget.photoUrl,
          imagebuilder: (context, imageProvider) {
            return Image(
              image: _image != null ? Image.file(_image!).image : imageProvider,
              width: double.infinity,
              height: double.infinity,
            );
          },
          errorBuilder: (context, url, error) {
            return Container();
          },
        ),
      ),
      Positioned(
        bottom: 8,
        right: 8,
        child: BaseLargeButton(
          text: 'Upload',
          onPressed: _choosePhoto,
        ),
      ),
      Positioned(
        bottom: 8,
        left: 8,
        child: BaseLargeButton(
          text: 'Generate Image',
          onPressed: _generateImage,
        ),
      )
    ]);
  }

  Future _generateImage() async {}

  Future _choosePhoto() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: AppConstants.profileImageMaxWidth,
        maxHeight: AppConstants.profileImageMaxWidth);
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worknetwork/features/hub/data/repository/cover_image_repository.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/app_constants.dart';
import '../../../../core/widgets/base/base_container/base_container.dart';
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

    return Column(children: [
      Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: (widget.image != null)
            ? widget.image
            : BaseNetworkImage(
                imageUrl: widget.photoUrl,
                imagebuilder: (context, imageProvider) {
                  return Image(
                    image: _image != null
                        ? Image.file(_image!).image
                        : imageProvider,
                    width: double.infinity,
                    height: 250,
                  );
                },
                errorBuilder: (context, url, error) {
                  return Container();
                },
              ),
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        children: [
          Positioned(
            bottom: 8,
            left: 8,
            child: BaseLargeButton(
              text: 'Generate Image',
              onPressed: widget.onGenerateImage,
            ),
          ),
          const Spacer(),
          Positioned(
            bottom: 8,
            right: 8,
            child: BaseLargeButton(
              text: 'Upload',
              onPressed: _choosePhoto,
            ),
          ),
        ],
      )
    ]);
  }

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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/app_constants.dart';
import '../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../core/widgets/base/base_network_image/base_network_image.dart';

class ProfilePhotoPicker extends StatefulWidget {
  final String? photoUrl;
  final Function(File)? onChoosePhoto;

  const ProfilePhotoPicker({Key? key, this.photoUrl, this.onChoosePhoto})
      : super(key: key);

  @override
  _ProfilePhotoPickerState createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    const double imageRadius = 56.00;

    return Stack(children: [
      BaseContainer(
        radius: 100,
        child: SizedBox(
          width: 200,
          height: 200,
          child: BaseNetworkImage(
            imageUrl: widget.photoUrl,
            defaultImage: AppImageAssets.articleDefault,
            imagebuilder: (context, imageProvider) {
              return CircleAvatar(
                backgroundImage:
                    _image != null ? Image.file(_image!).image : imageProvider,
                radius: 100,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey[200]!.withAlpha(20),
                    borderRadius: BorderRadius.circular(imageRadius),
                    onTap: _choosePhoto,
                  ),
                ),
              );
            },
            errorBuilder: (context, url, error) {
              return const CircleAvatar(
                backgroundImage: AppImageAssets.defaultAvatar,
                radius: 100,
              );
            },
          ),
        ),
      ),
      Positioned(
        bottom: 8,
        right: 8,
        child: BaseContainer(
          radius: 30,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _choosePhoto,
          ),
        ),
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

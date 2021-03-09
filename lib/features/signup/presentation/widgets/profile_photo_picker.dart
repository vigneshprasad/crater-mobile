import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worknetwork/constants/app_constants.dart';

class ProfilePhotoPicker extends StatefulWidget {
  final String photoUrl;
  final Function(File) onChoosePhoto;

  const ProfilePhotoPicker({Key key, this.photoUrl, this.onChoosePhoto})
      : super(key: key);

  @override
  _ProfilePhotoPickerState createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    const double imageRadius = 56.00;
    return CircleAvatar(
      backgroundImage: _image != null
          ? Image.file(_image).image
          : NetworkImage(widget.photoUrl),
      radius: 56,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey[200].withAlpha(20),
          borderRadius: BorderRadius.circular(imageRadius),
          onTap: _choosePhoto,
        ),
      ),
    );
  }

  Future _choosePhoto() async {
    final pickedFile = await picker.getImage(
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

    widget.onChoosePhoto(_image);
  }
}

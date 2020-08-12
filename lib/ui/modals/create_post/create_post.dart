import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worknetwork/blocs/auth/bloc/auth_bloc.dart';
import 'package:worknetwork/blocs/post/bloc/post_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/base/image_thumb/image_thumb.dart';
import 'package:worknetwork/utils/app_localizations.dart';
import 'package:worknetwork/utils/get_multipartfiles.dart';

class CreatePost extends StatefulWidget {
  final PostBloc postBloc;

  const CreatePost({Key key, this.postBloc}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<File> _images = [];
  String _postMessage = '';
  final ImagePicker picker = ImagePicker();
  final TextEditingController _postMessageController = TextEditingController();

  @override
  void initState() {
    _postMessageController.addListener(_onChangePostText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final onPressPost = _postMessage.isEmpty ? null : onSubmitCreatePost;
    return Scaffold(
      appBar: BaseAppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.send),
            color: primaryColor,
            onPressed: onPressPost,
          )
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return buildBody(context, state);
        },
      ),
    );
  }

  void clearForm() {
    _postMessageController.clear();
    setState(() {
      _images = [];
    });
  }

  Future<void> onSubmitCreatePost() async {
    final files = await getMultiPartFiles(_images, 'files_formdata');
    widget.postBloc.add(PostCreateStarted(message: _postMessage, files: files));
  }

  void _onChangePostText() {
    setState(() {
      _postMessage = _postMessageController.text;
    });
  }

  Widget buildBody(BuildContext context, AuthState state) {
    final label = AppLocalizations.of(context).translate('create_post:label');
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          getHeader(state),
          BlocBuilder<PostBloc, PostState>(
            cubit: widget.postBloc,
            builder: (context, state) {
              if (state is PostCreateLoading) {
                return const LinearProgressIndicator();
              } else {
                return Container();
              }
            },
          ),
          BlocConsumer<PostBloc, PostState>(
            cubit: widget.postBloc,
            listener: (context, state) {
              if (state is PostCreateCompleted) {
                clearForm();
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              var enable = true;
              if (state is PostCreateLoading) enable = false;
              return Expanded(
                child: TextField(
                  enabled: enable,
                  controller: _postMessageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: AppInsets.xl),
                    hintText: label,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  autofocus: true,
                ),
              );
            },
          ),
          if (_images.isNotEmpty) buildImagesList(),
          getActionsRow()
        ],
      ),
    );
  }

  Widget buildImagesList() {
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.med, horizontal: AppInsets.med),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _images.length,
        itemBuilder: _buildImageItem,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppInsets.med),
      ),
    );
  }

  Widget _buildImageItem(BuildContext context, int index) {
    final image = _images[index];
    return ImageThumb(
      image: AssetImage(image.path),
      onClosePress: () {
        final updated = _images;
        updated.removeAt(index);
        setState(() {
          _images = updated;
        });
      },
    );
  }

  Widget getActionsRow() {
    const cameraImage = AssetImage('assets/images/ic_camera.png');
    return Material(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Image(
              image: cameraImage,
            ),
            onPressed: getImage,
          ),
        ],
      ),
    );
  }

  Widget getHeader(AuthState state) {
    final profilePhoto = state.user.photo;
    final name = state.user.name;
    final labelTheme = Theme.of(context).textTheme.subtitle2;
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xl,
          vertical: AppInsets.l,
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(profilePhoto),
            ),
            const SizedBox(width: AppPadding.med),
            Text(
              name,
              style: labelTheme,
            )
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        final updated = _images;
        updated.add(File(pickedFile.path));
        _images = updated;
      });
    } catch (_) {
      // ignore: avoid_print
      print(_);
    }
  }

  @override
  void dispose() {
    _postMessageController.dispose();
    super.dispose();
  }
}

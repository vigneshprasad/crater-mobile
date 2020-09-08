import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/create_post/create_post_bloc.dart';
import '../widgets/image_thumb.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _controller;
  List<File> _images;
  CreatePostBloc _bloc;
  String _message = "";
  final _picker = ImagePicker();

  @override
  void initState() {
    _images = [];
    _controller = TextEditingController();
    _bloc = KiwiContainer().resolve<CreatePostBloc>();
    _controller.addListener(_textEditingListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        AppLocalizations.of(context).translate("create_post:app_header");
    final label = AppLocalizations.of(context).translate('create_post:label');
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = authState.user;
        return BlocProvider.value(
          value: _bloc,
          child: BlocListener<CreatePostBloc, CreatePostState>(
            listener: (context, state) {
              if (state is CreatPostRequestSuccessLoaded) {
                ExtendedNavigator.of(context).pop(state.post);
              }
            },
            child: Scaffold(
              appBar: BaseAppBar(
                title: Text(title, style: AppTheme.appBarTitle),
                color: Colors.white,
                actions: [
                  IconButton(
                    icon: const Icon(WorkNetIcons.send),
                    color: Theme.of(context).primaryColor,
                    onPressed: _message.isEmpty ? null : _onPressSend,
                  )
                ],
              ),
              body: Column(
                children: [
                  _buildUserAvatarSection(context, user),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppInsets.xl),
                        hintText: label,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      autofocus: true,
                    ),
                  ),
                  if (_images.isNotEmpty) _buildImagesPreview(),
                  _buildActionsRow(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserAvatarSection(BuildContext context, User user) {
    final nameStyle = Theme.of(context).textTheme.subtitle2;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.xl, vertical: AppInsets.l),
      color: Colors.white,
      child: Row(
        children: [
          _buildAvatarImage(user),
          const SizedBox(width: AppInsets.med),
          Text(user.name, style: nameStyle),
        ],
      ),
    );
  }

  Widget _buildAvatarImage(User user) {
    if (user.photo != null) {
      return CachedNetworkImage(
        imageUrl: user.photo,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            backgroundImage: imageProvider,
          );
        },
      );
    } else {
      return const CircleAvatar(backgroundImage: AppImageAssets.defaultAvatar);
    }
  }

  Widget _buildActionsRow(BuildContext context) {
    const cameraImage = AssetImage('assets/images/ic_camera.png');
    return Material(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Image(
              image: cameraImage,
            ),
            onPressed: _onImageAddPressed,
          ),
        ],
      ),
    );
  }

  Future<void> _onImageAddPressed() async {
    try {
      final file = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _images.add(File(file.path));
      });
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  Widget _buildImagesPreview() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(AppInsets.med),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final image = _images[index];
          return ImageThumb(
            image: AssetImage(image.path),
            onClosePress: () {
              setState(() {
                _images.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }

  void _textEditingListener() {
    setState(() {
      _message = _controller.text;
    });
  }

  void _onPressSend() {
    _bloc.add(CreatePostRequestStarted(images: _images, message: _message));
  }
}

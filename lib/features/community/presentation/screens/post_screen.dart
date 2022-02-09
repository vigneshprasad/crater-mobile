import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../ui/base/post_card/post_card.dart';
import '../../../../ui/components/chat_input_bar/chat_input_bar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/post_entity.dart';
import '../bloc/post/post_bloc.dart';

class PostScreen extends StatefulWidget {
  final int postId;

  const PostScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late int _currentPage;
  late PostBloc _bloc;
  late Post? _post;
  late List<Comment> _comments;
  late TextEditingController _controller;
  late String _comment;
  final _pageSize = 10;

  @override
  void initState() {
    _currentPage = 1;
    _comments = [];
    _controller = TextEditingController();
    _bloc = KiwiContainer().resolve<PostBloc>()
      ..add(
        GetPostRequestStarted(postId: widget.postId),
      )
      ..add(GetPostCommentsRequest(
        page: _currentPage,
        postId: widget.postId,
        pageSize: _pageSize,
      ));
    _controller.addListener(_textEditingController);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<PostBloc, PostState>(
        listener: _blocListener,
        builder: (context, state) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Scaffold(
                appBar: BaseAppBar(
                  title: const Text("Post", style: AppTheme.appBarTitle),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: _buildContent(context),
                    ),
                    ChatInputBar(
                      controller: _controller,
                      placeholder: "Add a comment",
                      onSubmitPress: () => _onSubmitCommentPressed(
                          authState as AuthStateSuccess),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _blocListener(BuildContext context, PostState state) {
    if (state is PostResponseLoaded) {
      setState(() {
        _post = state.post;
      });
    } else if (state is GetPostCommentsResponseLoaded) {
      setState(() {
        _comments = state.comments!;
        _currentPage = state.currentPage!;
      });
    } else if (state is CreatePostResponseReceived) {
      setState(() {
        _comments.insert(0, state.comment);
      });
    }
  }

  Widget _buildContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (_post != null)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.med),
            sliver: SliverToBoxAdapter(
              child: PostCard(
                post: _post!,
                showActions: false,
              ),
            ),
          ),
        if (_comments.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.xl,
              vertical: AppInsets.l,
            ),
            sliver: SliverToBoxAdapter(
              child: _buildCommentsHeading(context),
            ),
          ),
        if (_comments.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.med),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                _buildCommentsList,
                childCount: _comments.length,
              ),
            ),
          )
      ],
    );
  }

  Widget _buildCommentsList(BuildContext context, int index) {
    final comment = _comments[index];
    final formatTime = DateFormat('MMM dd h:mm a');
    final messageTextStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        );
    final subtitleStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 12,
          color: Colors.grey,
        );
    return ListTile(
      leading: _buildAvatarIcon(comment),
      title: Text(comment.message ?? '', style: messageTextStyle),
      subtitle: Text(formatTime.format(comment.created!), style: subtitleStyle),
    );
  }

  Widget _buildAvatarIcon(Comment comment) {
    if (comment.creatorPhoto != null) {
      return CachedNetworkImage(
        imageUrl: comment.creatorPhoto!,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(backgroundImage: imageProvider);
        },
      );
    } else {
      return const CircleAvatar(backgroundImage: AppImageAssets.defaultAvatar);
    }
  }

  Widget _buildCommentsHeading(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.subtitle2?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.grey[600],
        );
    return Text("Comments", style: headingStyle);
  }

  void _textEditingController() {
    setState(() {
      _comment = _controller.text;
    });
  }

  void _onSubmitCommentPressed(AuthStateSuccess authState) {
    final user = authState.user!;
    _bloc.add(CreatePostRequestStarted(
      creator: user.pk ?? '',
      message: _comment,
      postId: widget.postId,
    ));
    FocusScope.of(context).unfocus();
    _controller.clear();
  }
}

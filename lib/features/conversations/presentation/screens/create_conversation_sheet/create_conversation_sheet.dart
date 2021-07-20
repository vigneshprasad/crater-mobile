import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/error/failures/failures.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import 'create_conversation_sheet_state.dart';

const kSheetRadius = Radius.circular(32.00);

class CreateConversationSheet extends PopupRoute<Topic> {
  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (notification.extent <= notification.minExtent) {
          Navigator.maybePop(context);
          return false;
        }
        return true;
      },
      child: DraggableScrollableSheet(
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return _SheetContent(controller: scrollController);
        },
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }
}

class _SheetIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Center(
        child: Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final Topic topic;
  final VoidCallback onBackPress;

  const _SheetHeader({
    Key key,
    this.topic,
    this.onBackPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline6;
    if (topic == null) {
      final label =
          AppLocalizations.of(context).translate("roundtable_sheet:heading");
      final style = Theme.of(context).textTheme.headline6;
      return SizedBox(
        height: 72,
        child: Center(
          child: Text(
            label,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 72,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPress,
            ),
            Text(
              topic.name,
              style: style,
            ),
          ],
        ),
      );
    }
  }
}

class _SheetContent extends HookWidget {
  final ScrollController controller;

  const _SheetContent({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final _topic = useState<Topic>(null);
    final getTopicsProvider = useProvider(getRootTopicsProvider);

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.only(topLeft: kSheetRadius, topRight: kSheetRadius),
        ),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverToBoxAdapter(child: _SheetIndicator()),
            SliverToBoxAdapter(
              child: _SheetHeader(
                topic: _topic.value,
                onBackPress: () {
                  _topic.value = null;
                  getTopicsProvider.getAllRootTopics();
                },
              ),
            ),
            _TopicsList(
              onPressedItem: (topic) {
                _topic.value = topic;
                _onPressTopic(_topic.value, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressTopic(Topic topic, BuildContext context) async {
    final response = await context
        .read(getRootTopicsProvider)
        .getTopicsForParentTopic(topic.id);

    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
        Navigator.pop(context);
      },
      (topics) {
        if (topics.isEmpty) {
          AutoRouter.of(context).pop(topic);
        }
      },
    );
  }
}

class _Loader extends StatelessWidget {
  final Failure error;

  const _Loader({
    Key key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: Text("Something went wrong"),
        ),
      ),
    );
  }
}

class _TopicsList extends HookWidget {
  final ValueChanged<Topic> onPressedItem;

  const _TopicsList({
    this.onPressedItem,
  });

  @override
  Widget build(BuildContext context) {
    final getTopicsState = useProvider(getRootTopicsProvider.state);

    return getTopicsState.when(
      loading: () => const _Loader(),
      data: (topics) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _TopicItem(
              category: topics[index],
              onItemPressed: (value) {
                if (onPressedItem != null) {
                  onPressedItem(value);
                }
              },
            ),
            childCount: topics.length,
          ),
        );
      },
      error: (error, st) => _Error(),
    );
  }
}

class _TopicItem extends StatelessWidget {
  final Topic category;
  final ValueChanged<Topic> onItemPressed;

  const _TopicItem({
    Key key,
    @required this.category,
    @required this.onItemPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1;
    final primaryColor = Theme.of(context).primaryColor;
    return Material(
      color: Colors.white,
      child: ListTile(
        title: Text(
          category.name,
          style: labelStyle,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: primaryColor,
        ),
        onTap: () => onItemPressed(category),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_shimmer_loader/base_shimmer_loader.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../roundtable_tab/roundtable_tab.dart';
import '../roundtables_page/roundtables_page_state.dart';
import 'topics_filter_list_state.dart';

const _kHeightCategoryList = 64.00;
const _kThumbnailSize = 48.00;

class TopicsFilterList extends HookWidget {
  final RoundTablePageType type;
  final ValueChanged<String> onPressAction;

  const TopicsFilterList({
    Key key,
    @required this.type,
    @required this.onPressAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Topic> selected = useState();
    final roundTablesNotifier = useProvider(roundtablePageStateProvider(type));
    final TopicsFilterNotifier categoryNotifier =
        useProvider(topicsStateProvider(type));
    useEffect(() {
      categoryNotifier.getRoundTableCategories(type);
      selected.value = null;
      return;
    }, [type]);
    final categoriesState = useProvider(topicsStateProvider(type).state);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: _kHeightCategoryList,
      child: categoriesState.when(
        loading: () => _Loader(),
        data: (topics) {
          final List<Widget> children = [];
          if (type == RoundTablePageType.all) {
            children.add(_ActionItem(
              icon: Icons.person_pin,
              label: "My Conversations",
              onPressed: () {
                onPressAction('my_conversation');
              },
            ));
          }
          for (final topic in topics) {
            children.add(
              _TopicItem(
                item: topic,
                selected: selected.value == topic,
                onPressed: (val) {
                  if (selected.value == val) {
                    selected.value = null;
                    roundTablesNotifier.getInitalData();
                  } else {
                    selected.value = val;
                    roundTablesNotifier.filterTables([val]);
                  }
                },
              ),
            );
          }
          return ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: AppInsets.xl),
            children: children,
          );
        },
        error: (error, stackTrace) {
          return Container(color: Colors.red);
        },
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: AppInsets.xl),
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      separatorBuilder: (context, index) => const SizedBox(width: AppInsets.xl),
      itemBuilder: (context, index) => BaseShimmerLoader(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: 48,
              color: Colors.white,
            ),
            const SizedBox(width: AppInsets.med),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 10,
                  color: Colors.white,
                ),
                const SizedBox(height: AppInsets.l),
                Container(
                  width: 72,
                  height: 8,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  const _ActionItem({
    Key key,
    @required this.label,
    @required this.onPressed,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontWeight: FontWeight.w800,
        );
    final subheadStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 13,
          color: Colors.grey,
        );
    final borderRadius = BorderRadius.circular(6.0);
    return Material(
      borderRadius: borderRadius,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onPressed();
        },
        borderRadius: borderRadius,
        child: Container(
          width: 164,
          padding: const EdgeInsets.symmetric(horizontal: AppInsets.med),
          child: Row(
            children: [
              Container(
                width: _kThumbnailSize,
                height: _kThumbnailSize,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: borderRadius,
                  boxShadow: kElevationToShadow[2],
                ),
                child: Center(
                  child: Icon(icon, color: Colors.white),
                ),
              ),
              const SizedBox(width: AppInsets.med),
              Flexible(
                child: Text(
                  label,
                  style: headingStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicItem extends StatelessWidget {
  final Topic item;
  final ValueChanged<Topic> onPressed;
  final bool selected;

  const _TopicItem({
    Key key,
    @required this.item,
    @required this.onPressed,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontWeight: FontWeight.w800,
        );
    final subheadStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 13,
          color: Colors.grey,
        );
    final borderRadius = BorderRadius.circular(6.0);
    return Material(
      borderRadius: borderRadius,
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          onPressed(item);
        },
        borderRadius: borderRadius,
        child: Container(
          width: 164,
          padding: const EdgeInsets.symmetric(horizontal: AppInsets.med),
          child: Row(
            children: [
              _buildThumbnail(item),
              const SizedBox(width: AppInsets.med),
              Flexible(
                child: Text(
                  item.name,
                  style: headingStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(Topic category) => BaseNetworkImage(
        imageUrl: category.image,
        defaultImage: AppImageAssets.videoPlaceholder,
        imagebuilder: (context, imageProvider) {
          return Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(image: imageProvider),
              boxShadow: kElevationToShadow[2],
            ),
          );
        },
      );
}

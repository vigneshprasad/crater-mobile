import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../constants/theme.dart';
import '../../../domain/entity/category_entity/category_entity.dart';
import '../roundtable_tab/roundtable_tab.dart';
import '../roundtables_page/roundtables_page_state.dart';
import 'category_list_state.dart';

const _kHeightCategoryList = 72.00;

class CategoriesList extends HookWidget {
  final RoundTablePageType type;

  const CategoriesList({
    Key key,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Category> selected = useState();
    final CategoryNotifier categoryNotifier =
        useProvider(categoriesStateProvider(type));
    final RoundTablesNotifier roundTablesNotifier =
        useProvider(roundTablesStateNotifier(type));
    useEffect(() {
      categoryNotifier.getRoundTableCategories(type);
      return;
    }, [type]);
    final categoriesState = useProvider(categoriesStateProvider(type).state);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: _kHeightCategoryList,
      child: categoriesState.when(
        loading: () => const LinearProgressIndicator(),
        data: (categories) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.only(left: AppInsets.xl),
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppInsets.med),
            itemBuilder: (context, index) => _CategoryItem(
              item: categories[index],
              selected: selected.value == categories[index],
              onPressed: (val) {
                if (selected.value == val) {
                  selected.value = null;
                  roundTablesNotifier.getRoundTables(type);
                } else {
                  selected.value = val;
                  roundTablesNotifier.filterRoundTables(val, type);
                }
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return Container(color: Colors.red);
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category item;
  final ValueChanged<Category> onPressed;
  final bool selected;

  const _CategoryItem({
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: headingStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppInsets.sm),
                    Text(
                      "4 meetings",
                      style: subheadStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(Category category) => CachedNetworkImage(
        imageUrl: category.image,
        imageBuilder: (context, imageProvider) {
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

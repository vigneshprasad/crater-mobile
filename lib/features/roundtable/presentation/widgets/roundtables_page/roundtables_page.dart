import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/features/roundtable/presentation/widgets/roundtable_tab/roundtable_tab.dart';

import '../../../../../constants/theme.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../roundtable_card/roundtable_card.dart';

class RoundTablesPage extends HookWidget {
  final RoundTablePageType type;
  final List<RoundTable> tables;

  const RoundTablesPage({
    @required this.type,
    @required this.tables,
  });

  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController(
      viewportFraction: 0.85,
    );
    return PageView.builder(
      controller: _pageController,
      itemCount: tables.length,
      itemBuilder: (context, index) {
        return Center(
          child: SizedBox.fromSize(
            size: MediaQuery.of(context).size,
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppInsets.sm,
                right: AppInsets.sm,
                top: 16,
                bottom: 84,
              ),
              child: RoundTableCard(
                table: tables[index],
              ),
            ),
          ),
        );
      },
    );
  }
}

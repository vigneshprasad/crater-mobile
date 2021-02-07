import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../../constants/theme.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../roundtable_card/roundtable_card.dart';
import '../roundtable_tab/roundtable_tab.dart';
import 'roundtables_page_state.dart';

class RoundTablesPage extends HookWidget {
  final RoundTablePageType type;

  const RoundTablesPage({
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final tableState = useProvider(roundTablesStateNotifier(type).state);
    return Container(
      color: Colors.transparent,
      child: tableState.when(
        loading: () => _Loader(),
        data: (tables) => _ScrollableCards(tables: tables),
        error: (error, stackTrace) => Container(color: Colors.red),
      ),
    );
  }
}

class _ScrollableCards extends HookWidget {
  final List<RoundTable> tables;

  const _ScrollableCards({
    @required this.tables,
  });

  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController(viewportFraction: 0.85);
    return PageView.builder(
      controller: _pageController,
      itemCount: tables.length,
      itemBuilder: (context, index) {
        final User user = KiwiContainer().resolve<AuthBloc>().state.user;
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
                user: user,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

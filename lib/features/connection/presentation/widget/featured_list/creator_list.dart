import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';

import 'creator_follow_card.dart';
import 'creator_list_state.dart';

class CreatorList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.profile;
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(creatorStateProvider('').notifier)
            .getNextPageProfileList('');
      }
    });
    final connectionState = useProvider(creatorStateProvider(''));
    return connectionState.when(
        loading: () => Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).accentColor,
        )),
        error: (err, st) => Center(
          child: err == null ? Container() : Text(err.toString()),
        ),
        data: (items) {
          return items.isEmpty
            ? Container()
            : Wrap(
              direction: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(
                    'Creators to follow',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 20,),
                    controller: _controller,
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(20, 8, 8, 40),
                    itemBuilder: (context, index) => CreatorFollowCard(
                      item: items[index],
                      authUserPk: user?.pk,
                    ),
                  ),
                ),
              ],
            );
        });
  }
}
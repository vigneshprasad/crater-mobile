import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_reactions_screen_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/chat_reaction_entity/chat_reaction_entity.dart';

class ChatReactionsScreen extends HookConsumerWidget {
  const ChatReactionsScreen({required this.onReactionSelect});
  final Function(ChatReaction) onReactionSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactionScreenState = ref.read(reactionStateProvider(''));
    return Scaffold(
      // appBar: BaseAppBar(),
      body: reactionScreenState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (reactions) => GridView.builder(
          itemCount: reactions.length,
          padding: const EdgeInsets.all(AppInsets.med),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) => InkWell(
            onTap: () => onReactionSelect(reactions[index]),
            child: ChatReactionTile(
              item: reactions[index],
            ),
          ),
        ),
        error: (err, st) => Center(
          child: Text(err.toString()),
        ),
      ),
    );
  }
}

class ChatReactionTile extends StatelessWidget {
  final ChatReaction item;

  const ChatReactionTile({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        item.image ?? '',
        height: 50,
        width: 50,
      ),
    );
  }
}

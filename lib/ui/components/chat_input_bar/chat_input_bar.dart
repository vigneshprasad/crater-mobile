import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../constants/work_net_icons_icons.dart';
import '../../../features/auth/domain/entity/user_entity.dart';

class ChatInputBar extends StatelessWidget {
  final User? user;
  final TextEditingController? controller;
  final VoidCallback? onSubmitPress;
  final VoidCallback? onReactionPress;
  final String? placeholder;

  const ChatInputBar({
    Key? key,
    this.user,
    this.controller,
    this.onSubmitPress,
    this.onReactionPress,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const inputRadius = 12.00;
    final width = MediaQuery.of(context).size.width;
    final textStyle = Theme.of(context).textTheme.subtitle1;
    final labelStyle =
        Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey);
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      width: width,
      padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.med, vertical: AppInsets.l),
      child: Row(
        children: [
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).primaryColor,
            child: InkWell(
              focusColor: AppTheme.primarySwatch.shade600,
              splashColor: AppTheme.primarySwatch.shade700,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onTap: onReactionPress,
              child: const SizedBox(
                width: 48,
                height: 44,
                child: Center(
                  child: Icon(
                    Icons.emoji_emotions,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppInsets.l),
          Flexible(
            child: TextField(
              controller: controller,
              style: textStyle,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: AppInsets.xl),
                hintText: placeholder,
                filled: true,
                // fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(inputRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[100]!, width: 2),
                  borderRadius: BorderRadius.circular(inputRadius),
                ),
                hintStyle: labelStyle,
              ),
            ),
          ),
          const SizedBox(width: AppInsets.l),
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).primaryColor,
            child: InkWell(
              focusColor: AppTheme.primarySwatch.shade600,
              splashColor: AppTheme.primarySwatch.shade700,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onTap: onSubmitPress,
              child: const SizedBox(
                width: 48,
                height: 44,
                child: Center(
                  child: Icon(
                    WorkNetIcons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

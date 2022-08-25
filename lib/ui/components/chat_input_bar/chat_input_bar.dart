import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worknetwork/constants/app_constants.dart';

import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

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
    const inputRadius = 0.0;
    final width = MediaQuery.of(context).size.width;
    final textStyle = Theme.of(context).textTheme.titleSmall;
    final labelStyle = Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(color: HexColor.fromHex('#9D9D9D'));
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: AppInsets.l,
      ),
      child: Row(
        children: [
          Flexible(
            child: Stack(
              children: [
                TextField(
                  controller: controller,
                  style: textStyle,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    hintText: placeholder,
                    filled: true,
                    fillColor: HexColor.fromHex('#010101'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(inputRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      borderRadius: BorderRadius.circular(inputRadius),
                    ),
                    hintStyle: labelStyle,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: AppTheme.primarySwatch.shade600,
                      splashColor: AppTheme.primarySwatch.shade700,
                      onTap: onSubmitPress,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          width: 28,
                          height: 28,
                          child: Center(
                            child: SvgPicture.asset(AppSvgAssets.send),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

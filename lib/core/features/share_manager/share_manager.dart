import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';
import '../../../constants/app_constants.dart';

final shareManagerProvider = Provider<ShareManager>((_) => ShareManagerImpl());

abstract class ShareManager {
  Future<void> share(BuildContext context);
}

final appUrl =
    Uri.encodeComponent('https://worknetwork.onelink.me/KbQv/AppStore');
final shareText = Uri.encodeComponent(AppConstants.defaultShareText);
final summary = Uri.encodeComponent("Know any relevant people?");
const hashtags = 'crater';
final twitterUrl = 'https://twitter.com/share?text=$shareText';
// final twitterUrl =
// 'https://twitter.com/share?url=$appUrl&text=$shareText&via=1WorkNetwork&hashtags=$hashtags';
// const twitterDeepLink =
//     'twitter://post?message=$shareText%20https://www.worknetwork.ai';

final fbUrl = 'https://www.facebook.com/sharer.php?u=$appUrl';
final linkedUrl =
    'https://www.linkedin.com/shareArticle?mini=true&url=$appUrl&title=$shareText&summary=$summary&source=worknetwork.ai';

// const whatsAppDeepLink = 'whatsapp://send?text=https://www.worknetwork.ai';
final whatsAppUrl = 'https://api.whatsapp.com/send?text=$shareText';

class ShareManagerImpl implements ShareManager {
  @override
  Future<void> share(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareBottomSheet(),
    );
  }
}

class ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const iconSize = 44.0;
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
          topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
        ),
        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          height: 480,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invite your friends & increase your score',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'By adding people to the network, your network strength increases & thereby, improves the quality of matches you get.',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Image.asset(
                          'assets/images/meeting_scheduled.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          launch(
                            whatsAppUrl,
                            forceSafariVC: false,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/whatsapp.png',
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text('Invite via Whatsapp'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
                  topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
                ),
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).backgroundColor,
                  padding: const EdgeInsets.all(40),
                  child: Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      IconButton(
                          iconSize: iconSize,
                          icon: SvgPicture.asset(
                            AppSvgAssets.linkedinFilled,
                            height: iconSize,
                            width: iconSize,
                          ),
                          onPressed: () {
                            launch(
                              linkedUrl,
                              forceSafariVC: false,
                            );
                          }),
                      IconButton(
                          iconSize: iconSize,
                          icon: SvgPicture.asset(
                            AppSvgAssets.twitter,
                            height: iconSize,
                            width: iconSize,
                          ),
                          onPressed: () {
                            launch(
                              twitterUrl,
                              forceSafariVC: false,
                            );
                          }),
                      // IconButton(
                      //     iconSize: iconSize,
                      //     icon: Image.asset('assets/images/facebook.png'),
                      //     onPressed: () {
                      //       launch(
                      //         fbUrl,
                      //         forceSafariVC: false,
                      //         forceWebView: false,
                      //       );
                      //     }),
                      IconButton(
                          iconSize: iconSize,
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.ios_share,
                              size: iconSize - 16,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Share.share(
                              AppConstants.defaultShareText,
                            );
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/app_constants.dart';

final shareManagerProvider = Provider<ShareManager>((_) => ShareManagerImpl());

abstract class ShareManager {
  Future<void> share(BuildContext context);
}

final appUrl =
    Uri.encodeComponent('https://worknetwork.onelink.me/KbQv/AppStore');
final shareText = Uri.encodeComponent(AppConstants.defaultShareText);
final summary = Uri.encodeComponent("Know any relevant people?");
const hashtags = 'worknetwork';
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
    showModalBottomSheet(
      context: context,
      builder: (context) => ShareBottomSheet(),
    );
  }
}

class ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const iconSize = 44.0;
    return Container(
      height: 480,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Refer your friends',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            children: [
              IconButton(
                  iconSize: iconSize,
                  icon: Image.asset('assets/images/whatsapp.png'),
                  onPressed: () {
                    launch(
                      whatsAppUrl,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  }),
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
                      forceWebView: false,
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
                      forceWebView: false,
                    );
                  }),
              IconButton(
                  iconSize: iconSize,
                  icon: Image.asset('assets/images/facebook.png'),
                  onPressed: () {
                    launch(
                      fbUrl,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  }),
              IconButton(
                  iconSize: iconSize,
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.more_horiz,
                      size: iconSize - 8,
                    ),
                  ),
                  onPressed: () {
                    Share.share(
                      AppConstants.defaultShareText,
                      subject: summary,
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

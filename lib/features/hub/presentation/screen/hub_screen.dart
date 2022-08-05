import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/hub/presentation/screen/create_stream_screen.dart';
import 'package:worknetwork/features/hub/presentation/screen/hub_screen_state.dart';
import 'package:worknetwork/features/hub/presentation/screen/wallet_screen.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class HubScreen extends HookConsumerWidget {
  const HubScreen({Key? key}) : super(key: key);

  static const tabs = ["Streams", "Wallet"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(hubScreenProvider(0));

    final index = useState(0);

    return profileState.when(
      data: (state) => Scaffold(
        body: DefaultTabController(
          length: tabs.length,
          child: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 80,
                  collapsedHeight: 50,
                  toolbarHeight: 50,
                  flexibleSpace: const AccentTitle(
                    title: 'Hub',
                    leftPadding: 24,
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size(double.infinity, 50),
                    child: SizedBox(
                      height: 40,
                      child: TabBar(
                        onTap: (i) {
                          index.value = i;
                        },
                        tabs: tabs.map((e) => Tab(child: Text(e))).toList(),
                      ),
                    ),
                  ),
                )
              ],
              body: TabBarView(
                children: [
                  if (state.permission.allowCreateStream ?? false)
                    CreateStreamScreen()
                  else
                    SizedBox(
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do you want to stream? Connect with us',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BaseLargeButton(
                              text: 'Become a Creator',
                              onPressed: onPressBecomeCreator,
                            )
                          ],
                        ),
                      ),
                    ),
                  const WalletScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
      loading: () => Container(),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }

  void onPressBecomeCreator() {
    launchUrlString(
      'https://calendly.com/craterclub/?utm_source=creator_hub&utm_medium=website&utm_campaign=creator',
      mode: LaunchMode.inAppWebView,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/hub/presentation/screen/hub_screen_state.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import 'create_stream_screen.dart';

class HubScreen extends HookWidget {
  const HubScreen({Key? key}) : super(key: key);

  static const tabs = ["Streams"]; //, "Wallet"];

  @override
  Widget build(BuildContext context) {
    final profileState = useProvider(hubScreenProvider(0));

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
                          )),
                    ),
                  )
                ],
                body: TabBarView(
                  children: [
                    if (state.permission.allowCreateStream ?? false)
                      CreateStreamScreen()
                    else
                      Expanded(
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
                    // const WalletScreen(),
                  ],
                ),
              ),
            )),
      ),
      loading: () => Container(),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }

  void onPressBecomeCreator() {
    launch(
        'https://calendly.com/craterclub/?utm_source=creator_hub&utm_medium=website&utm_campaign=creator');
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text(
            'How it works?',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how1.png',
                width: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                'Share the referral link with your friends',
                style: Theme.of(context).textTheme.subtitle1,
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how2.png',
                width: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'Your friend uses  the link to sign up & watch their first stream',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how3.png',
                width: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                'You get ₹50 when they watch their first 20min of live content.',
                style: Theme.of(context).textTheme.subtitle1,
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how4.png',
                width: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                'Withdraw the money or use it at the auctions',
                style: Theme.of(context).textTheme.subtitle1,
              )),
            ],
          )
        ],
      ),
    );
  }
}

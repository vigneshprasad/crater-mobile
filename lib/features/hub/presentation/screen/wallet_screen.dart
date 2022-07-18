import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/hub/presentation/screen/wallet_screen_state.dart';

class WalletScreen extends HookConsumerWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletScreenProvider(0));

    var items = ['Referral', 'Watched Stream', 'Payable', 'Status'];

    final controller = useScrollController();
    controller.addListener(() {
      // reached End of scroll
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        ref.read(walletScreenProvider(0).notifier).retrieveNextPage();
      }
    });

    return walletState.when(
      data: (data) {
        if (data.referrals.isEmpty) {
          return const ReferralInstruction();
        }
        for (final element in data.referrals) {
          items += [
            element.user ?? '',
            '      -',
            '${element.amount ?? 0}',
            element.status ?? ''
          ];
        }
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: GridView.builder(
            controller: controller,
            itemCount: items.length,
            padding: const EdgeInsets.all(AppInsets.med),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) => GridTile(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    top: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    bottom: (index >= items.length - 4)
                        ? const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          )
                        : const BorderSide(width: 0),
                  ),
                ),
                child: Text(
                  items[index],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      error: (error, stack) => Container(),
    );
  }
}

class ReferralInstruction extends StatelessWidget {
  const ReferralInstruction({Key? key}) : super(key: key);

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
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how1.png',
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'Share the referral link with your friends',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how2.png',
                width: 50,
              ),
              const SizedBox(
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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how3.png',
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'You get ₹50 when they watch their first 20min of live content.',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/wallet_how4.png',
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'Withdraw the money or use it at the auctions',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

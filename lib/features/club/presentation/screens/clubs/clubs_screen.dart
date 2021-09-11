import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/screens/clubs/clubs_screen_state.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab_state.dart';

class ClubsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();
    final clubsProvider = useProvider(clubsStateProvider);

    final _tab = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MaterialButton(
                onPressed: () {
                  _tab.value = 0;
                  const offset = 0.0;
                  _scrollController.animateTo(offset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Live'),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 20,
                      height: 1,
                      color: _tab.value == 0 ? Colors.blue : null,
                    )
                  ],
                )),
            MaterialButton(
                onPressed: () {
                  _tab.value = 1;
                  const offset = 400.0;
                  _scrollController.animateTo(offset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Upcoming'),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 20,
                      height: 1,
                      color: _tab.value == 1 ? Colors.blue : null,
                    )
                  ],
                )),
          ],
        ),
      ),
      body: clubsProvider.when(
          loading: () => Container(),
          error: (e, s) => Container(),
          data: (streams) => GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: streams.first.conversations.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 0.65,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GridTile(
                      child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/img_drawer_image.png',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                              ),
                              child: Text(
                                '1 DAY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        color: Theme.of(context)
                            .dialogBackgroundColor
                            .withAlpha(50),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Vivan Puri',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.white, width: 0.5),
                                  ),
                                  child: Text(
                                    'Marketing',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum ',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
                );
              })),
    );
  }
}

class LiveSteamListView extends HookWidget {
  const LiveSteamListView({
    Key? key,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).dialogBackgroundColor.withAlpha(50),
              ),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/img_drawer_image.png',
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 12),
                        child: Chip(
                          visualDensity: VisualDensity.compact,
                          label: const Text('LIVE'),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    title: const Text('Vivan Puri'),
                    subtitle: const Text(
                      'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black,
                    ),
                    trailing: Chip(
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: const Text(
                        'Marketing',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ],
              ));
        },
        separatorBuilder: (context, index) {
          return Container();
        },
        itemCount: 5);
  }
}

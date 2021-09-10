import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ClubsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();
    final _tab = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MaterialButton(
                onPressed: () {
                  _tab.value = 0;
                  final offset = 0.0;
                  _scrollController.animateTo(offset,
                      duration: Duration(milliseconds: 300),
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
                  final offset = 400.0;
                  _scrollController.animateTo(offset,
                      duration: Duration(milliseconds: 300),
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
      body: ListView.separated(
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
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
          itemCount: 5),
    );
  }
}

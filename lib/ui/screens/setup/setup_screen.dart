import 'package:flutter/material.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class SetupScreen extends StatefulWidget {
  final String initialTab;

  const SetupScreen({Key key, this.initialTab}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final List<Step> _profileSteps = [
    Step(
      title: const Text('Basic Profile'),
      isActive: true,
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Introduce yourself'),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Introduce yourself'),
          )
        ],
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              steps: _profileSteps,
            ),
          ),
        ],
      ),
    );
  }
}

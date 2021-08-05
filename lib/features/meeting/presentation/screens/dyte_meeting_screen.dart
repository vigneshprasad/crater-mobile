import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class DyteMeetingScreen extends StatefulWidget {
  const DyteMeetingScreen({Key? key}) : super(key: key);

  @override
  _DyteMeetingScreenState createState() => _DyteMeetingScreenState();
}

class _DyteMeetingScreenState extends State<DyteMeetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(),
        body: SafeArea(
          child: DyteMeeting(
            roomName: "oripsd-eockll",
            authToken:
                "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRiMDMxYmNjLWNlZWUtNDQ4ZC1iYTBkLTk0NTRlOGVmZWYzOCIsImxvZ2dlZEluIjp0cnVlLCJpYXQiOjE2MjgxNjE3OTUsImV4cCI6MTYyODI0ODE5NX0.ur9I0BICkJLEZCs8QZ79Z-GpLRMzD3PaTbeAosC2Er-v_qSCVDMnLmt7J7k0L-4pu-vSv-xWIMlGlEB0ccChcgeYHLoy_imnH8FNohM_a079CKZkvpDRWgVtfzlyfCNPe73ILOWMqEhKlrErxymGB1tr75G0LbHQ7TisFMxmJXgiTLGc1bZGLgbXpczyywjv8vCdODgQGQqe0fxEs8Vbsg6vNoo2IWTE0sHHKMjrgpJFevVpb8uJQ8QB3f1BwbqF1chb6ayNMFg4JZbRzykTDnHyFxXRm2wkiCfsHuymNxZCoKBuDXU9ThqfpCBfoH8l103ivpgdldd5NLStHkuA1w",
            onInit: (DyteMeetingHandler meeting) async {},
          ),
        ));
  }
}

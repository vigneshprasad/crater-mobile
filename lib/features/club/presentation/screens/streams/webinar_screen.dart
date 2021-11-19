import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebinarScreen extends StatelessWidget {
  final String webUrl;
  const WebinarScreen({Key? key, required this.webUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: webUrl,
          allowsInlineMediaPlayback: true,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}

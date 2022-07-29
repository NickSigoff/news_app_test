import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  final String url;
  late WebViewController webController;

  ArticlePage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webController.canGoBack()) {
          webController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: WebView(
          onWebViewCreated: (WebViewController webViewController) {
            webController = webViewController;
          },
          initialUrl: url,
        ),
      ),
    );
  }
}

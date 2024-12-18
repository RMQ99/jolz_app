import 'package:webview_flutter/webview_flutter.dart';

class WebViewDataSource {
  final WebViewController controller;


  WebViewDataSource(this.controller);

  Future<void> loadUrl() async {
    await controller.loadRequest(Uri.parse('https://jolz.sa'));
  }

  Future<void> reload() async {
    await controller.reload();
  }
}




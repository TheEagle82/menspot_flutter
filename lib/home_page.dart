import 'package:flutter/material.dart';
import 'package:menspot_flutter/menspot_webview.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        bottomOpacity: 0,

      ),
      body: MenspotWebView(
        title: "Menspot",
        selectedUrl: "https://menspot.net"
      )
    );
  }
}
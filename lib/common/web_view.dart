import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ZoomWebinarScreen extends StatefulWidget {
  final String webinarJoinUrl;
  final String userName;

  const ZoomWebinarScreen({
    super.key,
    required this.webinarJoinUrl,
    required this.userName,
  });

  @override
  ZoomWebinarScreenState createState() => ZoomWebinarScreenState();
}

class ZoomWebinarScreenState extends State<ZoomWebinarScreen> {
  late WebViewController _controller;
  bool isLoading = true; // Loader state

  @override
  void initState() {
    super.initState();
    String formattedUrl = convertZoomUrl(
        zoomUrl: widget.webinarJoinUrl, username: widget.userName);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(Platform.isIOS
          ? "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"
          : null)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => isLoading = true); // Show loader
            if (url.contains("zoom.us/postattendee") ||
                url.contains("zoom.us/wc/leave") ||
                url.contains("zoom.us/ended") ||
                url.contains("app.zoom.us/wc")) {
              Navigator.pop(context);
            }
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false); // Hide loader
          },
        ),
      )
      ..loadRequest(Uri.parse(formattedUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff1F0A68)),
                        strokeWidth: 4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Joining Webinar...",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700]),
                    )
                  ],
                ),
              )
            : WebViewWidget(controller: _controller),
      ),
    );
  }

  String convertZoomUrl({required String zoomUrl, required String username}) {
    String updatedUrl = zoomUrl.contains("/j/")
        ? zoomUrl.replaceAll("/j/", "/wc/join/")
        : zoomUrl;

    String encodedUsername = Uri.encodeComponent(username);

    return "$updatedUrl?uname=$encodedUsername";
  }
}

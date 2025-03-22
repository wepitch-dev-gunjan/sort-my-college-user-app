import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ZoomWebinarScreen extends StatefulWidget {
  final String webinarJoinUrl;
  final String userName;
  const ZoomWebinarScreen(
      {super.key, required this.webinarJoinUrl, required this.userName});

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
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => isLoading = true); // Show loader
            log("Navigating to: $url");

            if (url.contains("zoom.us/postattendee") ||
                url.contains("zoom.us/wc/leave") ||
                url.contains("zoom.us/ended") ||
                url.contains("app.zoom.us/wc")) {
              log("✅ Meeting Ended, Redirecting to HomeScreen...");
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
                      width: 50, // Set size
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff1F0A68)),
                        strokeWidth: 4, // Thickness
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

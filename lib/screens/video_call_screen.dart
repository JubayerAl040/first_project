import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final GlobalKey webViewKey = GlobalKey();
  bool _isVideoCallStart = false, _isZoomEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => setState(() => _isVideoCallStart = true),
                child: const Text("Go to url............"),
              ),
            ),
            !_isVideoCallStart
                ? const SizedBox()
                : _isZoomEnable
                    ? Positioned.fill(child: _showVideoCall())
                    : Positioned(
                        top: 5,
                        right: 5,
                        width: 70,
                        height: 80,
                        child: _showVideoCall(),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _showVideoCall() {
    return Stack(
      children: [
        Positioned.fill(
          child: InAppWebView(
            key: webViewKey,
            initialSettings: InAppWebViewSettings(
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              iframeAllow: "camera; microphone",
              iframeAllowFullscreen: true,
              preferredContentMode: UserPreferredContentMode.DESKTOP,
            ),
            initialUrlRequest: URLRequest(url: WebUri('https://flutter.dev')),
            onLoadStart: (controller, url) =>
                const Center(child: CircularProgressIndicator()),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              backgroundColor: Colors.black,
            ),
            child:
                const Icon(Icons.close_outlined, size: 11, color: Colors.white),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: ElevatedButton(
            onPressed: () {
              _isVideoCallStart = false;
              _isZoomEnable = !_isZoomEnable;
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(2),
              backgroundColor: Colors.black,
            ),
            child: Icon(
                _isZoomEnable
                    ? Icons.home_mini_outlined
                    : Icons.home_max_outlined,
                size: 11,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}

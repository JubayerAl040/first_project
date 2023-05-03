import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // recenvier
          Positioned.fill(
            child: Image.asset('assets/images/doctor.jpg', fit: BoxFit.cover),
          ),
          // buttons botton
          VideoCButtons(size: size),
          // caller
          VideoCCaller(size: size),
        ],
      ),
    );
  }
}

class VideoCMuteButton extends StatefulWidget {
  const VideoCMuteButton({super.key});
  @override
  State<VideoCMuteButton> createState() => _VideoCMuteButtonState();
}

class _VideoCMuteButtonState extends State<VideoCMuteButton> {
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isMute = !isMute),
      child: _getVideoIcon(
          isMute ? Icons.mic_none_outlined : Icons.mic_off_outlined),
    );
  }
}

class VideoCVideoButton extends StatefulWidget {
  const VideoCVideoButton({super.key});

  @override
  State<VideoCVideoButton> createState() => _VideoCVideoButtonState();
}

class _VideoCVideoButtonState extends State<VideoCVideoButton> {
  bool onVideo = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => onVideo = !onVideo),
      child: _getVideoIcon(
          onVideo ? Icons.videocam_outlined : Icons.videocam_off_outlined),
    );
  }
}

class VideoCButtons extends StatelessWidget {
  const VideoCButtons({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: -30,
      right: -30,
      height: size.height * .12,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              spreadRadius: 3,
              blurRadius: 60,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 50),
            const VideoCMuteButton(),
            Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white12),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white24,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                  ),
                  child: const Icon(Icons.phone, color: Colors.white),
                ),
              ),
            ),
            VideoCVideoButton(),
            const SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}

class VideoCCaller extends StatefulWidget {
  const VideoCCaller({super.key, required this.size});
  final Size size;
  @override
  State<VideoCCaller> createState() => _VideoCCallerState();
}

class _VideoCCallerState extends State<VideoCCaller> {
  OverlayEntry? entry;
  Offset? offset;

  @override
  void initState() {
    super.initState();
    offset = Offset(widget.size.width * .7, 28);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset!.dx,
      top: offset!.dy,
      width: widget.size.width * .3,
      height: widget.size.height * .18,
      child: GestureDetector(
        onPanUpdate: (details) =>
            setState(() => offset = offset! + details.delta),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFBDBDBD)),
            image: const DecorationImage(
              image: AssetImage('assets/images/user.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // void showOverlay() {
  //   entry = OverlayEntry(
  //     builder: (ctx) => ElevatedButton.icon(
  //       onPressed: () {},
  //       icon: const Icon(Icons.shop),
  //       label: const Text('Record'),
  //     ),
  //   );
  //   final overlay = Overlay.of(context);
  //   overlay.insert(entry!);
  // }
}

Container _getVideoIcon(IconData icon) => Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(10),
      //alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white24,
      ),
      child: Icon(icon, color: Colors.white),
    );

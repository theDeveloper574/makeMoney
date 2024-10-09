import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DepositVideo extends StatefulWidget {
  const DepositVideo({super.key});

  @override
  State<DepositVideo> createState() => _DepositVideoState();
}

class _DepositVideoState extends State<DepositVideo> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/vidoe/jazz-cash.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(64),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            height: Get.height,
            width: double.infinity,
            child: _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            left: Get.width / 2.4,
            child: GestureDetector(
              onTap: () {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.stop : Icons.play_arrow,
                size: 60, // Increased size for better visibility
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

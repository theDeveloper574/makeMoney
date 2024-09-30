import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/widgets/mobile_card_widget.dart';
import 'package:video_player/video_player.dart';

class MobileComponent extends StatefulWidget {
  const MobileComponent({super.key});

  @override
  State<MobileComponent> createState() => _MobileComponentState();
}

class _MobileComponentState extends State<MobileComponent> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/vidoe/app_develop.mp4');
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
      appBar: AppBar(
        title: const Text("Mobile Development"),
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.04),
          MobieCardWidget(
            text: 'Graphic designing',
            image: LocalImg.graphic,
          ),
          MobieCardWidget(
            text: 'Mobile Application',
            image: LocalImg.mobileApp,
          ),
          MobieCardWidget(
            text: 'WhatsApp Chat App',
            image: LocalImg.whatsApp,
          ),
          MobieCardWidget(
            text: 'Freelancing Course',
            image: LocalImg.freelance,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: Get.height / 3,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
                Positioned(
                  bottom: 0,
                  left: Get.width /
                      2.6, // You can adjust this to position the button
                  child: GestureDetector(
                    onTap: () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.stop
                          : Icons.play_arrow,
                      size: 50, // Increased size for better visibility
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/service/stateManagment/provider/mobile_course_provider.dart';
import 'package:makemoney/widgets/mobile_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/course_request_widget.dart';

class MobileComponent extends StatefulWidget {
  const MobileComponent({super.key});

  @override
  State<MobileComponent> createState() => _MobileComponentState();
}

class _MobileComponentState extends State<MobileComponent> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // _getDocumentCount();
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
    // _getDocumentCount();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Development"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Consumer<MobileCourseProvider>(
                  builder: (context, value, child) {
                return Text(
                    "Mobile Course Request: ${value.courseCount.toString()}");
              }),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                ":کورس کی درخواستیں",
                style: TextStyle(fontSize: 12),
              ),
            ),
            MobileCardWidget(
              onTap: () {
                Get.to(() => const CourseRequestWidget());
              },
              text: 'Graphic designing',
              image: LocalImg.graphic,
            ),
            MobileCardWidget(
              onTap: () {
                Get.to(() => const CourseRequestWidget());
              },
              text: 'Mobile Application',
              image: LocalImg.mobileApp,
            ),
            MobileCardWidget(
              onTap: () {
                Get.to(() => const CourseRequestWidget());
              },
              text: 'WhatsApp Chat App',
              image: LocalImg.whatsApp,
            ),
            MobileCardWidget(
              onTap: () {
                Get.to(() => const CourseRequestWidget());
              },
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
      ),
    );
  }

  // final _db = FirebaseFirestore.instance.collection("courseRequest");
  // String documentCount = 'loading';
  // Future<void> _getDocumentCount() async {
  //   // Fetch all documents in the 'courseRequest' collection
  //   QuerySnapshot querySnapshot = await _db.get();
  //
  //   // Get the count of documents
  //   setState(() {
  //     documentCount = querySnapshot.docs.length.toString();
  //   });
  // }
}

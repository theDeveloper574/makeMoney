import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../service/stateManagment/provider/user_account_provider.dart';

class ChatUserView extends StatefulWidget {
  const ChatUserView({super.key});

  @override
  State<ChatUserView> createState() => _ChatUserViewState();
}

class _ChatUserViewState extends State<ChatUserView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ));
    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize();
    final userCount = Provider.of<UserAccountProvider>(context, listen: false);
    userCount.fetchUsers();
    userCount.fetchUsersInvest();
    super.initState();
  }

  bool isPLaying = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
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
              // Play Button (overlay)
              Positioned(
                bottom: 0,
                left:
                    Get.width / 4, // You can adjust this to position the button
                child: GestureDetector(
                  onTap: () {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  },
                  child: Icon(
                    _controller.value.isPlaying ? Icons.stop : Icons.play_arrow,
                    size: 50, // Increased size for better visibility
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: Get.width * 0.01),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            height: Get.height / 3,
            child: Consumer<UserAccountProvider>(
              builder: (context, value, child) {
                if (value.users.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.users.length,
                    itemBuilder: (context, index) {
                      final users = value.users[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppUtils().networkChaImage(users.profileUrl!),
                                SizedBox(width: Get.width * 0.016),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      users.name!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BinanceAdWidget extends StatefulWidget {
  const BinanceAdWidget({super.key});

  @override
  State<BinanceAdWidget> createState() => _BinanceAdWidgetState();
}

class _BinanceAdWidgetState extends State<BinanceAdWidget> {
  late VideoPlayerController _binance;
  @override
  void initState() {
    _binance = VideoPlayerController.asset('assets/vidoe/binance-ad.mp4');
    _binance.addListener(() {
      setState(() {});
    });
    _binance.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _binance.dispose();
    _binance.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _binance.pause();
        return true; // Allow the pop action
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () {
            _binance.value.isPlaying ? _binance.pause() : _binance.play();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _binance.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _binance.value.aspectRatio,
                    child: VideoPlayer(_binance),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
// _binance.value.isPlaying ? _binance.pause() : _binance.play();

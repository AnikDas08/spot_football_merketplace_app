import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CustomVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {}); // ভিডিও লোড হলে UI আপডেট হবে
      });

    // ভিডিও শেষ হলে আবার শুরু থেকে দেখানোর জন্য লিসেনার
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // সময় ফরম্যাট করার ফাংশন (00:00)
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // ভিডিও ডিসপ্লে
          VideoPlayer(_controller),

          // কাস্টম কন্ট্রোল লেয়ার
          _buildControls(),
        ],
      ),
    )
        : Container(
      height: 200.h,
      color: Colors.black,
      child: const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ভিডিওর স্লাইডার (Progress Bar)
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Colors.white,
              bufferedColor: Colors.white.withOpacity(0.3),
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              // প্লে/পজ বাটন
              GestureDetector(
                onTap: () {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 15.w),
              GestureDetector(
                onTap: () => _controller.seekTo(Duration.zero),
                child: Icon(Icons.replay, color: Colors.white, size: 22.sp),
              ),
              const Spacer(),
              Text(
                "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
              SizedBox(width: 15.w),
              Icon(Icons.fullscreen, color: Colors.white, size: 24.sp),
            ],
          ),
        ],
      ),
    );
  }
}
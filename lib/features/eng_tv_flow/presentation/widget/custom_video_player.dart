import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants/app_colors.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CustomVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer(widget.videoUrl);
  }

  void _initializePlayer(String url) {
    if (mounted) setState(() => _isInitialized = false);

    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _isInitialized = true);
          _controller.play();
        }
      }).catchError((error) {
        debugPrint("Video initialization error: $error");
      });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.pause();
      _controller.dispose();
      _initializePlayer(widget.videoUrl);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleFullScreen() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (!_isInitialized) {
      return Container(
        height: 200.h,
        width: double.infinity,
        color: Colors.black,
        child: Shimmer.fromColors(
          baseColor: Color(0xFFD2D2D2),
          highlightColor: Color(0xFFE5E5E5),
          child: Container(color: Colors.white),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: isLandscape ? MediaQuery.of(context).size.height : null,
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: isLandscape
              ? MediaQuery.of(context).size.aspectRatio
              : _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              _buildControls(isLandscape),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControls(bool isLandscape) {
    bool isVideoFinished =
        _controller.value.position >= _controller.value.duration;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: isLandscape ? 20.h : 10.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x00000000),
            Color(0xB3000000),
          ],          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.red,
              bufferedColor: Colors.white70,
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              GestureDetector(
                onTap: () => _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play(),
                child: Icon(
                  _controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 15.w),
              if (isVideoFinished)
                GestureDetector(
                  onTap: () {
                    _controller.seekTo(Duration.zero);
                    _controller.play();
                  },
                  child:
                  Icon(Icons.replay, color: Colors.white, size: 22.sp),
                ),
              const Spacer(),
              Text(
                "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
              SizedBox(width: 15.w),
              GestureDetector(
                onTap: _toggleFullScreen,
                child: Icon(
                  isLandscape ? Icons.fullscreen_exit : Icons.fullscreen,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
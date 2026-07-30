import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YouTubeVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const YouTubeVideoPlayer({super.key, required this.videoUrl});

  @override
  State<YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  bool _isFit = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
    debugPrint("🎬 [YouTube Player] Extracted ID: $videoId");
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        useHybridComposition: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant YouTubeVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      final newVideoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
      if (newVideoId != null) {
        debugPrint("🎬 [YouTube Player] Updating to New ID: $newVideoId");
        _controller.load(newVideoId);
      }
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        onReady: () {
          debugPrint("🎬 [YouTube Player] Ready to Play");
          setState(() {
            _isPlayerReady = true;
          });
        },
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          const PlaybackSpeedButton(),
          GestureDetector(
            onTap: () => setState(() => _isFit = !_isFit),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                _isFit ? Icons.fit_screen : Icons.fit_screen_outlined,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          const FullScreenButton(),
        ],
      ),
      builder: (context, player) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              _controller.value.isFullScreen
                  ? SizedBox.expand(
                      child: FittedBox(
                        fit: _isFit ? BoxFit.cover : BoxFit.contain,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 9 / 16,
                          child: player,
                        ),
                      ),
                    )
                  : player,
              if (!_isPlayerReady)
                Positioned.fill(
                  child: Shimmer.fromColors(
                    baseColor: const Color(0xFFD2D2D2),
                    highlightColor: const Color(0xFFE5E5E5),
                    child: Container(color: Colors.white),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

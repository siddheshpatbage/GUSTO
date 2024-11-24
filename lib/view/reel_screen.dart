import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final List<String> _videoUrls = [
    // Scenic and nature-themed video URLs
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4", // Nature
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", // Nature
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", // Nature
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4", // Nature
    "https://www.w3schools.com/html/mov_bbb.mp4", // Scenic Mountain
    "https://www.w3schools.com/html/movie.mp4", // Scenic Beach
    "https://www.w3schools.com/html/mov_bbb.mp4", // Ocean Scenery
    "https://www.w3schools.com/html/movie.mp4", // Sunset View
    // Add more scenic video URLs
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPlayerItem(videoUrl: _videoUrls[index]);
        },
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.7) {
          _controller.play();
        }
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Scenic Views & Travel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Explore the world's most beautiful landscapes.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Handle like functionality
                        },
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          // Handle comment functionality
                        },
                        icon: const Icon(Icons.comment, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          // Handle share functionality
                        },
                        icon: const Icon(Icons.share, color: Colors.white),
                      ),
                    ],
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

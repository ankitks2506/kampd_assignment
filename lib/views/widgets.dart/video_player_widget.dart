import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:kampd_assignment/models/get_videos_response_model.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Video video;

  const VideoPlayerWidget({super.key, required this.video});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  //Creating a single instance of the video player controller just the url changes
  //Using CachedVideoPlayer for caching the data and better performance
  late CachedVideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //Initialize the controller to play the video as soon as the screen loads
    _controller = CachedVideoPlayerController.network(widget.video.url!)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              //Tap to pause or play the video
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            },
            child: CachedVideoPlayer(_controller),
          ),
          Positioned(
            // stacking the caption on the video
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15.0),
              color: Colors.blueGrey.withOpacity(0.5),
              child: Text(
                widget.video.caption!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

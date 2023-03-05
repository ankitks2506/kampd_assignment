import 'package:kampd_assignment/models/get_videos_response_model.dart';

abstract class VideoState {}

class VideoInitialState extends VideoState {}

class VideoLoadingState extends VideoState {}

class VideoLoadedState extends VideoState {
  final List<Video> videos;

  VideoLoadedState({required this.videos});
}

class VideoErrorState extends VideoState {
  VideoErrorState();
}

//All the different states for the video
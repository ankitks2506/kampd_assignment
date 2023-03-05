import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampd_assignment/bloc/video_events.dart';
import 'package:kampd_assignment/bloc/video_states.dart';
import 'package:kampd_assignment/repository/video_repository.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;

  VideoBloc({required this.videoRepository}) : super(VideoInitialState()) {
    on<FetchVideos>((event, emit) async {
      emit(VideoLoadingState());
      try {
        final videos = await videoRepository.getVideos();
        emit(VideoLoadedState(videos: videos));
      } catch (_) {
        emit(VideoErrorState());
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kampd_assignment/bloc/video_bloc.dart';
import 'package:kampd_assignment/bloc/video_events.dart';
import 'package:kampd_assignment/bloc/video_states.dart';
import 'package:kampd_assignment/repository/video_repository.dart';
import 'package:kampd_assignment/views/widgets.dart/video_player_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final videoBloc = VideoBloc(videoRepository: VideoRepository());

  @override
  void initState() {
    // Calling the fetch function as soon as this screen is mounted
    super.initState();
    videoBloc.add(FetchVideos());
  }

  @override
  void dispose() {
    videoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Scroll for videos"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black87,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.speaker_notes_outlined),
          //   label: "Soapbox",
          //   activeIcon: Icon(
          //     Icons.speaker_notes_outlined,
          //     color: Colors.white,
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: "Create",
            activeIcon: Icon(
              Icons.person_2_outlined,
              color: Colors.white,
            ),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search_rounded),
          //   label: "Explore",
          //   activeIcon: Icon(
          //     Icons.person_2_outlined,
          //     color: Colors.white,
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
            activeIcon: Icon(
              Icons.person_2_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<VideoBloc, VideoState>(
          bloc: videoBloc,
          builder: (context, state) {
            if (state is VideoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VideoLoadedState) {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.videos.length,
                itemBuilder: (context, index) {
                  final video = state.videos[index];

                  return VideoPlayerWidget(video: video);
                },
              );
            } else if (state is VideoErrorState) {
              return GestureDetector(
                child: const Center(
                  child:
                      Text('Oops! Failed to load video. Pull down to refresh.'),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

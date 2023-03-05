abstract class VideoEvent {}

class FetchVideos extends VideoEvent {} 
//Created only fetch event for now but we wil have lots of events such as like 
//the video, comment or share and multiple user interactions are possible
//However just used one event for now.

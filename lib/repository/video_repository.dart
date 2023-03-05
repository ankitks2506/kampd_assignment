import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kampd_assignment/constants/app_strings.dart';
import 'package:kampd_assignment/models/get_videos_response_model.dart';
import 'package:http/http.dart' as http;

class VideoRepository {
  Future<List<Video>> getVideos() async {
    List<Video> videos = [];
    var decodedJson = {};

    //make the API Call here
    final response = await http.get(
      Uri.parse(AppStrings.baseUrl),
    );

    if (response.statusCode == 200) {
      String body = response.body;
      //Had to do the following when json was not formatted correctly and
      //there was an extra comma
      // String body1 = body.substring(0, body.length - 2);
      // body1 += body.substring((body.length - 2), body.length);

      decodedJson = json.decode(body);
      debugPrint(decodedJson.toString());
      //convert to a list of videos
      for (var video in decodedJson["data"]) {
        videos.add(Video.fromJson(video));
      }
      return videos;
    } else {
      throw Exception('Failed to load video');
    }
  }
}

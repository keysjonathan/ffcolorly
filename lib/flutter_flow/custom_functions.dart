import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';

bool hasUploadedMedia(String mediaPath) {
  return mediaPath != null && mediaPath.isNotEmpty;
}

int likes(PostsRecord post) {
  return post.likes.length;
}

String getMapUrl(LatLng restLatLong) {
  return 'https://www.google.com/maps/search/?api=1&'
      'query=${restLatLong.latitude},${restLatLong.longitude}';
}

String getAverageRating(List<PostsRecord> posts) {
  if (posts.isEmpty) {
    return '-';
  }
  var ratingsSum = 0.0;
  for (final post in posts) {
    ratingsSum += post.userRating;
  }
  return '${(ratingsSum / posts.length).toStringAsFixed(1)}';
}

LatLng getInitialMapLocation(LatLng userLocation) {
  if (userLocation == null ||
      (userLocation.latitude == 0 && userLocation.longitude == 0)) {
    return LatLng(40.8295538, -73.9386429);
  }
  return userLocation;
}

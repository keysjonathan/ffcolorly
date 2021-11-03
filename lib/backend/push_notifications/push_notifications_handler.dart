import 'dart:async';
import 'dart:convert';

import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../explore/explore_widget.dart';
import '../../search_results/search_results_widget.dart';
import '../../login/login_widget.dart';
import '../../create_account/create_account_widget.dart';
import '../../restaurant_details/restaurant_details_widget.dart';
import '../../user_profile/user_profile_widget.dart';
import '../../edit_profile/edit_profile_widget.dart';
import '../../view_profile_other/view_profile_other_widget.dart';
import '../../rest_profile_page/rest_profile_page_widget.dart';
import '../../add_profile_info/add_profile_info_widget.dart';
import '../../onboarding/onboarding_widget.dart';
import '../../story_details/story_details_widget.dart';
import '../../chat_user/chat_user_widget.dart';
import '../../chat_main/chat_main_widget.dart';
import '../../search_users/search_users_widget.dart';
import '../../all_users/all_users_widget.dart';
import '../../add_story_page/add_story_page_widget.dart';
import '../../following/following_widget.dart';
import '../../followers/followers_widget.dart';
import '../../map_results_page/map_results_page_widget.dart';
import '../../edit_restaurant/edit_restaurant_widget.dart';
import '../../new_video_screen/new_video_screen_widget.dart';
import '../../new_video_screen_copy/new_video_screen_copy_widget.dart';
import '../../rest_profile_page_copy/rest_profile_page_copy_widget.dart';
import '../../phone_sign_in/phone_sign_in_widget.dart';
import '../../phone_verification/phone_verification_widget.dart';
import '../../blocked_users/blocked_users_widget.dart';
import '../../story_details_copy/story_details_copy_widget.dart';
import '../../new_home_page_copy/new_home_page_copy_widget.dart';

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler(
      {Key key, this.handlePushNotification, this.child})
      : super(key: key);

  final Function(BuildContext) handlePushNotification;
  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    setState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Builder(
            builder: (context) => Image.asset(
              'assets/images/1_Splash.png',
              fit: BoxFit.cover,
            ),
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'explore': (data) async =>
      hasMatchingParameters(data, {'restaurants', 'posts'})
          ? ExploreWidget(
              restaurants: await getDocumentParameter(
                  data, 'restaurants', RestaurantsRecord.serializer),
              posts: await getDocumentParameter(
                  data, 'posts', PostsRecord.serializer),
            )
          : NavBarPage(initialPage: 'ExploreWidget'),
  'searchResults': (data) async => SearchResultsWidget(),
  'login': (data) async => LoginWidget(),
  'createAccount': (data) async => CreateAccountWidget(),
  'restaurantDetails': (data) async => RestaurantDetailsWidget(
        restaurant: getParameter(data, 'restaurant'),
        posts:
            await getDocumentParameter(data, 'posts', PostsRecord.serializer),
      ),
  'userProfile': (data) async => hasMatchingParameters(
          data, {'posts', 'user', 'friends', 'post', 'likes'})
      ? UserProfileWidget(
          posts: getParameter(data, 'posts'),
          user:
              await getDocumentParameter(data, 'user', UsersRecord.serializer),
          friends: await getDocumentParameter(
              data, 'friends', FriendsRecord.serializer),
          post:
              await getDocumentParameter(data, 'post', PostsRecord.serializer),
          likes:
              await getDocumentParameter(data, 'likes', LikesRecord.serializer),
        )
      : NavBarPage(initialPage: 'UserProfileWidget'),
  'editProfile': (data) async => EditProfileWidget(
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
      ),
  'viewProfileOther': (data) async => ViewProfileOtherWidget(
        otherUser: getParameter(data, 'otherUser'),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        friends: await getDocumentParameter(
            data, 'friends', FriendsRecord.serializer),
      ),
  'restProfilePage': (data) async => RestProfilePageWidget(
        restaurant: await getDocumentParameter(
            data, 'restaurant', RestaurantsRecord.serializer),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        story:
            await getDocumentParameter(data, 'story', StoriesRecord.serializer),
      ),
  'addProfileInfo': (data) async => AddProfileInfoWidget(),
  'onboarding': (data) async => OnboardingWidget(),
  'storyDetails': (data) async => StoryDetailsWidget(
        initialStoryIndex: getParameter(data, 'initialStoryIndex'),
        restaurant: await getDocumentParameter(
            data, 'restaurant', RestaurantsRecord.serializer),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        stories: await getDocumentParameter(
            data, 'stories', StoriesRecord.serializer),
      ),
  'chatUser': (data) async => ChatUserWidget(
        chatUser: await getDocumentParameter(
            data, 'chatUser', UsersRecord.serializer),
      ),
  'chatMain': (data) async => hasMatchingParameters(data, {'user'})
      ? ChatMainWidget(
          user:
              await getDocumentParameter(data, 'user', UsersRecord.serializer),
        )
      : NavBarPage(initialPage: 'ChatMainWidget'),
  'searchUsers': (data) async => SearchUsersWidget(),
  'allUsers': (data) async => hasMatchingParameters(data, {'users'})
      ? AllUsersWidget(
          users:
              await getDocumentParameter(data, 'users', UsersRecord.serializer),
        )
      : NavBarPage(initialPage: 'AllUsersWidget'),
  'addStoryPage': (data) async => AddStoryPageWidget(
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        restaurant: await getDocumentParameter(
            data, 'restaurant', RestaurantsRecord.serializer),
      ),
  'following': (data) async => FollowingWidget(
        friends: await getDocumentParameter(
            data, 'friends', FriendsRecord.serializer),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
      ),
  'followers': (data) async => FollowersWidget(
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        friend: await getDocumentParameter(
            data, 'friend', FriendsRecord.serializer),
      ),
  'mapResultsPage': (data) async => MapResultsPageWidget(
        restaurant: getParameter(data, 'restaurant'),
      ),
  'editRestaurant': (data) async => EditRestaurantWidget(
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        restaurant: await getDocumentParameter(
            data, 'restaurant', RestaurantsRecord.serializer),
      ),
  'newVideoScreen': (data) async => NewVideoScreenWidget(
        initialStoryIndex: getParameter(data, 'initialStoryIndex'),
        restaurant: await getDocumentParameter(
            data, 'restaurant', RestaurantsRecord.serializer),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        post: getParameter(data, 'post'),
      ),
  'newVideoScreenCopy': (data) async => NewVideoScreenCopyWidget(
        initialStoryIndex: getParameter(data, 'initialStoryIndex'),
        restaurant: await getDocumentParameter(
            data, 'restaurant', RestaurantsRecord.serializer),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        post: getParameter(data, 'post'),
        hgcvk: getParameter(data, 'hgcvk'),
      ),
  'restProfilePageCopy': (data) async => RestProfilePageCopyWidget(
        restaurant: getParameter(data, 'restaurant'),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        story:
            await getDocumentParameter(data, 'story', StoriesRecord.serializer),
      ),
  'phoneSignIn': (data) async => PhoneSignInWidget(),
  'phoneVerification': (data) async => PhoneVerificationWidget(),
  'blockedUsers': (data) async => BlockedUsersWidget(
        friends: await getDocumentParameter(
            data, 'friends', FriendsRecord.serializer),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
      ),
  'storyDetailsCopy': (data) async => StoryDetailsCopyWidget(
        initialStoryIndex: getParameter(data, 'initialStoryIndex'),
        restaurant: await getDocumentParameter(
            data, 'restaurant', RestaurantsRecord.serializer),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        stories: await getDocumentParameter(
            data, 'stories', StoriesRecord.serializer),
      ),
  'newHomePageCopy': (data) async => NewHomePageCopyWidget(
        numLikes: getParameter(data, 'numLikes'),
        user: await getDocumentParameter(data, 'user', UsersRecord.serializer),
        userRef: getParameter(data, 'userRef'),
        friends: getParameter(data, 'friends'),
      ),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return json.decode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}

T getParameter<T>(Map<String, dynamic> data, String paramName) {
  try {
    if (!data.containsKey(paramName)) {
      return null;
    }
    final param = data[paramName];
    switch (T) {
      case String:
        return param;
      case double:
        return param.toDouble();
      case DateTime:
        return DateTime.fromMillisecondsSinceEpoch(param) as T;
      case LatLng:
        return latLngFromString(param) as T;
    }
    if (param is String) {
      return FirebaseFirestore.instance.doc(param) as T;
    }
    return param;
  } catch (e) {
    print('Error parsing parameter "$paramName": $e');
    return null;
  }
}

Future<T> getDocumentParameter<T>(
    Map<String, dynamic> data, String paramName, Serializer<T> serializer) {
  if (!data.containsKey(paramName)) {
    return null;
  }
  return FirebaseFirestore.instance
      .doc(data[paramName])
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));
}

final latRegex = RegExp(
    r'^(+|-)?(?:90(?:(?:.0{1,7})?)|(?:[0-9]|[1-8][0-9])(?:(?:.[0-9]{1,7})?))$');
final lngRegex = RegExp(
    r'^(+|-)?(?:180(?:(?:.0{1,7})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:.[0-9]{1,7})?))$');

LatLng latLngFromString(String latLngStr) {
  final pieces = latLngStr.split(',');
  if (pieces.length != 2) {
    return null;
  }
  final lat = pieces[0].trim();
  final lng = pieces[1].trim();
  if (!latRegex.hasMatch(lat)) {
    return null;
  }
  if (!lngRegex.hasMatch(lng)) {
    return null;
  }
  return LatLng(double.parse(lat), double.parse(lng));
}

import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'num_likes')
  int get numLikes;

  @nullable
  DocumentReference get user;

  @nullable
  String get username;

  @nullable
  @BuiltValueField(wireName: 'user_profile_pic')
  String get userProfilePic;

  @nullable
  @BuiltValueField(wireName: 'video_url')
  String get videoUrl;

  @nullable
  @BuiltValueField(wireName: 'num_shares')
  int get numShares;

  @nullable
  @BuiltValueField(wireName: 'num_comments')
  int get numComments;

  @nullable
  String get descritpion;

  @nullable
  @BuiltValueField(wireName: 'video_thumbnail')
  String get videoThumbnail;

  @nullable
  bool get liked;

  @nullable
  @BuiltValueField(wireName: 'restaurant_connect')
  DocumentReference get restaurantConnect;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  @BuiltValueField(wireName: 'restaurant_name')
  String get restaurantName;

  @nullable
  @BuiltValueField(wireName: 'user_rating')
  double get userRating;

  @nullable
  bool get diversetag;

  @nullable
  bool get inclusivetag;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..numLikes = 0
    ..username = ''
    ..userProfilePic = ''
    ..videoUrl = ''
    ..numShares = 0
    ..numComments = 0
    ..descritpion = ''
    ..videoThumbnail = ''
    ..liked = false
    ..restaurantName = ''
    ..userRating = 0.0
    ..diversetag = false
    ..inclusivetag = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PostsRecord._();
  factory PostsRecord([void Function(PostsRecordBuilder) updates]) =
      _$PostsRecord;

  static PostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPostsRecordData({
  int numLikes,
  DocumentReference user,
  String username,
  String userProfilePic,
  String videoUrl,
  int numShares,
  int numComments,
  String descritpion,
  String videoThumbnail,
  bool liked,
  DocumentReference restaurantConnect,
  DateTime createdAt,
  String restaurantName,
  double userRating,
  bool diversetag,
  bool inclusivetag,
}) =>
    serializers.toFirestore(
        PostsRecord.serializer,
        PostsRecord((p) => p
          ..numLikes = numLikes
          ..user = user
          ..username = username
          ..userProfilePic = userProfilePic
          ..videoUrl = videoUrl
          ..numShares = numShares
          ..numComments = numComments
          ..descritpion = descritpion
          ..videoThumbnail = videoThumbnail
          ..liked = liked
          ..restaurantConnect = restaurantConnect
          ..createdAt = createdAt
          ..restaurantName = restaurantName
          ..userRating = userRating
          ..diversetag = diversetag
          ..inclusivetag = inclusivetag));

import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'video_url')
  String get videoUrl;

  @nullable
  @BuiltValueField(wireName: 'restaurant_name')
  String get restaurantName;

  @nullable
  @BuiltValueField(wireName: 'user_rating')
  double get userRating;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  String get description;

  @nullable
  DocumentReference get user;

  @nullable
  String get username;

  @nullable
  @BuiltValueField(wireName: 'rest_ref')
  DocumentReference get restRef;

  @nullable
  BuiltList<DocumentReference> get likes;

  @nullable
  @BuiltValueField(wireName: 'video_thumbnail')
  String get videoThumbnail;

  @nullable
  bool get postOwner;

  @nullable
  @BuiltValueField(wireName: 'num_likes')
  int get numLikes;

  @nullable
  @BuiltValueField(wireName: 'num_comments')
  int get numComments;

  @nullable
  @BuiltValueField(wireName: 'num_shares')
  int get numShares;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..videoUrl = ''
    ..restaurantName = ''
    ..userRating = 0.0
    ..description = ''
    ..username = ''
    ..likes = ListBuilder()
    ..videoThumbnail = ''
    ..postOwner = false
    ..numLikes = 0
    ..numComments = 0
    ..numShares = 0;

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
  String videoUrl,
  String restaurantName,
  double userRating,
  DateTime createdAt,
  String description,
  DocumentReference user,
  String username,
  DocumentReference restRef,
  String videoThumbnail,
  bool postOwner,
  int numLikes,
  int numComments,
  int numShares,
}) =>
    serializers.toFirestore(
        PostsRecord.serializer,
        PostsRecord((p) => p
          ..videoUrl = videoUrl
          ..restaurantName = restaurantName
          ..userRating = userRating
          ..createdAt = createdAt
          ..description = description
          ..user = user
          ..username = username
          ..restRef = restRef
          ..likes = null
          ..videoThumbnail = videoThumbnail
          ..postOwner = postOwner
          ..numLikes = numLikes
          ..numComments = numComments
          ..numShares = numShares));

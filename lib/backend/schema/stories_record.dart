import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'stories_record.g.dart';

abstract class StoriesRecord
    implements Built<StoriesRecord, StoriesRecordBuilder> {
  static Serializer<StoriesRecord> get serializer => _$storiesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'video_url')
  String get videoUrl;

  @nullable
  @BuiltValueField(wireName: 'rest_ref')
  DocumentReference get restRef;

  @nullable
  String get comment;

  @nullable
  String get storyName;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  int get numComments;

  @nullable
  bool get isOwner;

  @nullable
  String get campaignName;

  @nullable
  @BuiltValueField(wireName: 'user_ref')
  DocumentReference get userRef;

  @nullable
  String get linkLearnMore;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(StoriesRecordBuilder builder) => builder
    ..videoUrl = ''
    ..comment = ''
    ..storyName = ''
    ..numComments = 0
    ..isOwner = false
    ..campaignName = ''
    ..linkLearnMore = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('stories');

  static Stream<StoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  StoriesRecord._();
  factory StoriesRecord([void Function(StoriesRecordBuilder) updates]) =
      _$StoriesRecord;

  static StoriesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createStoriesRecordData({
  String videoUrl,
  DocumentReference restRef,
  String comment,
  String storyName,
  DateTime createdTime,
  int numComments,
  bool isOwner,
  String campaignName,
  DocumentReference userRef,
  String linkLearnMore,
}) =>
    serializers.toFirestore(
        StoriesRecord.serializer,
        StoriesRecord((s) => s
          ..videoUrl = videoUrl
          ..restRef = restRef
          ..comment = comment
          ..storyName = storyName
          ..createdTime = createdTime
          ..numComments = numComments
          ..isOwner = isOwner
          ..campaignName = campaignName
          ..userRef = userRef
          ..linkLearnMore = linkLearnMore));

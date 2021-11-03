import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'flagged_videos_record.g.dart';

abstract class FlaggedVideosRecord
    implements Built<FlaggedVideosRecord, FlaggedVideosRecordBuilder> {
  static Serializer<FlaggedVideosRecord> get serializer =>
      _$flaggedVideosRecordSerializer;

  @nullable
  DocumentReference get userRef;

  @nullable
  BuiltList<DocumentReference> get postRef;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FlaggedVideosRecordBuilder builder) =>
      builder..postRef = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('flaggedVideos');

  static Stream<FlaggedVideosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FlaggedVideosRecord._();
  factory FlaggedVideosRecord(
          [void Function(FlaggedVideosRecordBuilder) updates]) =
      _$FlaggedVideosRecord;

  static FlaggedVideosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createFlaggedVideosRecordData({
  DocumentReference userRef,
}) =>
    serializers.toFirestore(
        FlaggedVideosRecord.serializer,
        FlaggedVideosRecord((f) => f
          ..userRef = userRef
          ..postRef = null));

import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'statistics_record.g.dart';

abstract class StatisticsRecord
    implements Built<StatisticsRecord, StatisticsRecordBuilder> {
  static Serializer<StatisticsRecord> get serializer =>
      _$statisticsRecordSerializer;

  @nullable
  int get numberOfFalvor;

  @nullable
  int get numberFollowers;

  @nullable
  int get numberFollowing;

  @nullable
  DocumentReference get userReference;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(StatisticsRecordBuilder builder) => builder
    ..numberOfFalvor = 0
    ..numberFollowers = 0
    ..numberFollowing = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('statistics');

  static Stream<StatisticsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  StatisticsRecord._();
  factory StatisticsRecord([void Function(StatisticsRecordBuilder) updates]) =
      _$StatisticsRecord;

  static StatisticsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createStatisticsRecordData({
  int numberOfFalvor,
  int numberFollowers,
  int numberFollowing,
  DocumentReference userReference,
}) =>
    serializers.toFirestore(
        StatisticsRecord.serializer,
        StatisticsRecord((s) => s
          ..numberOfFalvor = numberOfFalvor
          ..numberFollowers = numberFollowers
          ..numberFollowing = numberFollowing
          ..userReference = userReference));

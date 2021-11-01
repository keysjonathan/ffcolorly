import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'restaurant_menus_record.g.dart';

abstract class RestaurantMenusRecord
    implements Built<RestaurantMenusRecord, RestaurantMenusRecordBuilder> {
  static Serializer<RestaurantMenusRecord> get serializer =>
      _$restaurantMenusRecordSerializer;

  @nullable
  DocumentReference get restRef;

  @nullable
  String get course1;

  @nullable
  String get course2;

  @nullable
  String get course3;

  @nullable
  String get course4;

  @nullable
  String get course5;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RestaurantMenusRecordBuilder builder) =>
      builder
        ..course1 = ''
        ..course2 = ''
        ..course3 = ''
        ..course4 = ''
        ..course5 = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('restaurantMenus');

  static Stream<RestaurantMenusRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  RestaurantMenusRecord._();
  factory RestaurantMenusRecord(
          [void Function(RestaurantMenusRecordBuilder) updates]) =
      _$RestaurantMenusRecord;

  static RestaurantMenusRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createRestaurantMenusRecordData({
  DocumentReference restRef,
  String course1,
  String course2,
  String course3,
  String course4,
  String course5,
}) =>
    serializers.toFirestore(
        RestaurantMenusRecord.serializer,
        RestaurantMenusRecord((r) => r
          ..restRef = restRef
          ..course1 = course1
          ..course2 = course2
          ..course3 = course3
          ..course4 = course4
          ..course5 = course5));

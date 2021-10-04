import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'posts2_record.g.dart';

abstract class Posts2Record
    implements Built<Posts2Record, Posts2RecordBuilder> {
  static Serializer<Posts2Record> get serializer => _$posts2RecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'gif_url')
  String get gifUrl;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  DateTime get createdAt;

  @nullable
  String get video;

  @nullable
  DocumentReference get restaurant;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(Posts2RecordBuilder builder) => builder
    ..gifUrl = ''
    ..video = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts2');

  static Stream<Posts2Record> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  Posts2Record._();
  factory Posts2Record([void Function(Posts2RecordBuilder) updates]) =
      _$Posts2Record;

  static Posts2Record getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPosts2RecordData({
  String gifUrl,
  DocumentReference user,
  DateTime createdAt,
  String video,
  DocumentReference restaurant,
}) =>
    serializers.toFirestore(
        Posts2Record.serializer,
        Posts2Record((p) => p
          ..gifUrl = gifUrl
          ..user = user
          ..createdAt = createdAt
          ..video = video
          ..restaurant = restaurant));

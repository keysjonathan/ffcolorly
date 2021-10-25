import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get username;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  String get bio;

  @nullable
  @BuiltValueField(wireName: 'instagram_url')
  String get instagramUrl;

  @nullable
  @BuiltValueField(wireName: 'facebook_url')
  String get facebookUrl;

  @nullable
  @BuiltValueField(wireName: 'tiktok_url')
  String get tiktokUrl;

  @nullable
  String get website;

  @nullable
  bool get isRestaurant;

  @nullable
  DocumentReference get restaurantConnect;

  @nullable
  BuiltList<DocumentReference> get followers;

  @nullable
  BuiltList<DocumentReference> get following;

  @nullable
  BuiltList<int> get flavor;

  @nullable
  BuiltList<DocumentReference> get restConnections;

  @nullable
  int get flavorTotal;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..uid = ''
    ..displayName = ''
    ..username = ''
    ..photoUrl = ''
    ..email = ''
    ..phoneNumber = ''
    ..bio = ''
    ..instagramUrl = ''
    ..facebookUrl = ''
    ..tiktokUrl = ''
    ..website = ''
    ..isRestaurant = false
    ..followers = ListBuilder()
    ..following = ListBuilder()
    ..flavor = ListBuilder()
    ..restConnections = ListBuilder()
    ..flavorTotal = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => UsersRecord(
        (c) => c
          ..uid = snapshot.data['uid']
          ..displayName = snapshot.data['display_name']
          ..username = snapshot.data['username']
          ..photoUrl = snapshot.data['photo_url']
          ..email = snapshot.data['email']
          ..phoneNumber = snapshot.data['phone_number']
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..bio = snapshot.data['bio']
          ..instagramUrl = snapshot.data['instagram_url']
          ..facebookUrl = snapshot.data['facebook_url']
          ..tiktokUrl = snapshot.data['tiktok_url']
          ..website = snapshot.data['website']
          ..isRestaurant = snapshot.data['isRestaurant']
          ..restaurantConnect =
              safeGet(() => toRef(snapshot.data['restaurantConnect']))
          ..followers = safeGet(() =>
              ListBuilder(snapshot.data['followers'].map((s) => toRef(s))))
          ..following = safeGet(() =>
              ListBuilder(snapshot.data['following'].map((s) => toRef(s))))
          ..flavor = safeGet(() => ListBuilder(snapshot.data['flavor']))
          ..restConnections = safeGet(() => ListBuilder(
              snapshot.data['restConnections'].map((s) => toRef(s))))
          ..flavorTotal = snapshot.data['flavorTotal']
          ..reference = UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String uid,
  String displayName,
  String username,
  String photoUrl,
  String email,
  String phoneNumber,
  DateTime createdTime,
  String bio,
  String instagramUrl,
  String facebookUrl,
  String tiktokUrl,
  String website,
  bool isRestaurant,
  DocumentReference restaurantConnect,
  int flavorTotal,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..uid = uid
          ..displayName = displayName
          ..username = username
          ..photoUrl = photoUrl
          ..email = email
          ..phoneNumber = phoneNumber
          ..createdTime = createdTime
          ..bio = bio
          ..instagramUrl = instagramUrl
          ..facebookUrl = facebookUrl
          ..tiktokUrl = tiktokUrl
          ..website = website
          ..isRestaurant = isRestaurant
          ..restaurantConnect = restaurantConnect
          ..followers = null
          ..following = null
          ..flavor = null
          ..restConnections = null
          ..flavorTotal = flavorTotal));

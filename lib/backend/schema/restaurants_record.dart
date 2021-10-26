import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'restaurants_record.g.dart';

abstract class RestaurantsRecord
    implements Built<RestaurantsRecord, RestaurantsRecordBuilder> {
  static Serializer<RestaurantsRecord> get serializer =>
      _$restaurantsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'restaurant_name')
  String get restaurantName;

  @nullable
  @BuiltValueField(wireName: 'Logo')
  String get logo;

  @nullable
  @BuiltValueField(wireName: 'Featured_image')
  String get featuredImage;

  @nullable
  @BuiltValueField(wireName: 'rest_lat_long')
  LatLng get restLatLong;

  @nullable
  String get city;

  @nullable
  String get email;

  @nullable
  String get website;

  @nullable
  @BuiltValueField(wireName: 'price_range')
  String get priceRange;

  @nullable
  @BuiltValueField(wireName: 'rest_slogan')
  String get restSlogan;

  @nullable
  @BuiltValueField(wireName: 'rest_address')
  String get restAddress;

  @nullable
  int get reviews;

  @nullable
  @BuiltValueField(wireName: 'rest_description')
  String get restDescription;

  @nullable
  String get categories;

  @nullable
  double get rating;

  @nullable
  DocumentReference get userConnection;

  @nullable
  BuiltList<String> get gallery;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RestaurantsRecordBuilder builder) => builder
    ..restaurantName = ''
    ..logo = ''
    ..featuredImage = ''
    ..city = ''
    ..email = ''
    ..website = ''
    ..priceRange = ''
    ..restSlogan = ''
    ..restAddress = ''
    ..reviews = 0
    ..restDescription = ''
    ..categories = ''
    ..rating = 0.0
    ..gallery = ListBuilder()
    ..phoneNumber = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('restaurants');

  static Stream<RestaurantsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static RestaurantsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      RestaurantsRecord(
        (c) => c
          ..restaurantName = snapshot.data['restaurant_name']
          ..logo = snapshot.data['Logo']
          ..featuredImage = snapshot.data['Featured_image']
          ..restLatLong = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..city = snapshot.data['city']
          ..email = snapshot.data['email']
          ..website = snapshot.data['website']
          ..priceRange = snapshot.data['price_range']
          ..restSlogan = snapshot.data['rest_slogan']
          ..restAddress = snapshot.data['rest_address']
          ..reviews = snapshot.data['reviews']
          ..restDescription = snapshot.data['rest_description']
          ..categories = snapshot.data['categories']
          ..rating = snapshot.data['rating']
          ..userConnection =
              safeGet(() => toRef(snapshot.data['userConnection']))
          ..gallery = safeGet(() => ListBuilder(snapshot.data['gallery']))
          ..phoneNumber = snapshot.data['phone_number']
          ..reference = RestaurantsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<RestaurantsRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'restaurants',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  RestaurantsRecord._();
  factory RestaurantsRecord([void Function(RestaurantsRecordBuilder) updates]) =
      _$RestaurantsRecord;

  static RestaurantsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createRestaurantsRecordData({
  String restaurantName,
  String logo,
  String featuredImage,
  LatLng restLatLong,
  String city,
  String email,
  String website,
  String priceRange,
  String restSlogan,
  String restAddress,
  int reviews,
  String restDescription,
  String categories,
  double rating,
  DocumentReference userConnection,
  String phoneNumber,
}) =>
    serializers.toFirestore(
        RestaurantsRecord.serializer,
        RestaurantsRecord((r) => r
          ..restaurantName = restaurantName
          ..logo = logo
          ..featuredImage = featuredImage
          ..restLatLong = restLatLong
          ..city = city
          ..email = email
          ..website = website
          ..priceRange = priceRange
          ..restSlogan = restSlogan
          ..restAddress = restAddress
          ..reviews = reviews
          ..restDescription = restDescription
          ..categories = categories
          ..rating = rating
          ..userConnection = userConnection
          ..gallery = null
          ..phoneNumber = phoneNumber));

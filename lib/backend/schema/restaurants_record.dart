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
  @BuiltValueField(wireName: 'restaurant_address')
  String get restaurantAddress;

  @nullable
  @BuiltValueField(wireName: 'Featured_image')
  String get featuredImage;

  @nullable
  @BuiltValueField(wireName: 'Logo')
  String get logo;

  @nullable
  String get hours;

  @nullable
  String get tags;

  @nullable
  bool get bookmarked;

  @nullable
  @BuiltValueField(wireName: 'diverse_tag')
  bool get diverseTag;

  @nullable
  @BuiltValueField(wireName: 'rest_lat_long')
  LatLng get restLatLong;

  @nullable
  String get city;

  @nullable
  String get state;

  @nullable
  @BuiltValueField(wireName: 'postal_code')
  String get postalCode;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'price_range')
  String get priceRange;

  @nullable
  int get reviews;

  @nullable
  int get rating;

  @nullable
  @BuiltValueField(wireName: 'rest_description')
  String get restDescription;

  @nullable
  @BuiltValueField(wireName: 'post_ref')
  DocumentReference get postRef;

  @nullable
  String get website;

  @nullable
  @BuiltValueField(wireName: 'rest_slogan')
  String get restSlogan;

  @nullable
  BuiltList<double> get categories;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RestaurantsRecordBuilder builder) => builder
    ..restaurantName = ''
    ..restaurantAddress = ''
    ..featuredImage = ''
    ..logo = ''
    ..hours = ''
    ..tags = ''
    ..bookmarked = false
    ..diverseTag = false
    ..city = ''
    ..state = ''
    ..postalCode = ''
    ..email = ''
    ..priceRange = ''
    ..reviews = 0
    ..rating = 0
    ..restDescription = ''
    ..website = ''
    ..restSlogan = ''
    ..categories = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('restaurants');

  static Stream<RestaurantsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static RestaurantsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      RestaurantsRecord(
        (c) => c
          ..restaurantName = snapshot.data['restaurant_name']
          ..restaurantAddress = snapshot.data['restaurant_address']
          ..featuredImage = snapshot.data['Featured_image']
          ..logo = snapshot.data['Logo']
          ..hours = snapshot.data['hours']
          ..tags = snapshot.data['tags']
          ..bookmarked = snapshot.data['bookmarked']
          ..diverseTag = snapshot.data['diverse_tag']
          ..restLatLong = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..city = snapshot.data['city']
          ..state = snapshot.data['state']
          ..postalCode = snapshot.data['postal_code']
          ..email = snapshot.data['email']
          ..priceRange = snapshot.data['price_range']
          ..reviews = snapshot.data['reviews']
          ..rating = snapshot.data['rating']
          ..restDescription = snapshot.data['rest_description']
          ..postRef = safeGet(() => toRef(snapshot.data['post_ref']))
          ..website = snapshot.data['website']
          ..restSlogan = snapshot.data['rest_slogan']
          ..categories = safeGet(() => ListBuilder(snapshot.data['categories']))
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
  String restaurantAddress,
  String featuredImage,
  String logo,
  String hours,
  String tags,
  bool bookmarked,
  bool diverseTag,
  LatLng restLatLong,
  String city,
  String state,
  String postalCode,
  String email,
  String priceRange,
  int reviews,
  int rating,
  String restDescription,
  DocumentReference postRef,
  String website,
  String restSlogan,
}) =>
    serializers.toFirestore(
        RestaurantsRecord.serializer,
        RestaurantsRecord((r) => r
          ..restaurantName = restaurantName
          ..restaurantAddress = restaurantAddress
          ..featuredImage = featuredImage
          ..logo = logo
          ..hours = hours
          ..tags = tags
          ..bookmarked = bookmarked
          ..diverseTag = diverseTag
          ..restLatLong = restLatLong
          ..city = city
          ..state = state
          ..postalCode = postalCode
          ..email = email
          ..priceRange = priceRange
          ..reviews = reviews
          ..rating = rating
          ..restDescription = restDescription
          ..postRef = postRef
          ..website = website
          ..restSlogan = restSlogan
          ..categories = null));

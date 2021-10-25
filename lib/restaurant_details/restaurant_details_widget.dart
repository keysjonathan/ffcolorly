import '../backend/backend.dart';
import '../components/submit_review_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../new_video_screen_copy/new_video_screen_copy_widget.dart';
import '../story_details/story_details_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantDetailsWidget extends StatefulWidget {
  RestaurantDetailsWidget({
    Key key,
    this.restaurant,
    this.posts,
  }) : super(key: key);

  final DocumentReference restaurant;
  final PostsRecord posts;

  @override
  _RestaurantDetailsWidgetState createState() =>
      _RestaurantDetailsWidgetState();
}

class _RestaurantDetailsWidgetState extends State<RestaurantDetailsWidget>
    with TickerProviderStateMixin {
  LatLng googleMapsCenter;
  Completer<GoogleMapController> googleMapsController;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      curve: Curves.easeIn,
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostsRecord>>(
      stream: queryPostsRecord(
        queryBuilder: (postsRecord) =>
            postsRecord.where('rest_ref', isEqualTo: widget.restaurant),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitThreeBounce(
                color: FlutterFlowTheme.primaryColor,
                size: 50,
              ),
            ),
          );
        }
        List<PostsRecord> restaurantDetailsPostsRecordList = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: FlutterFlowTheme.primaryDark,
          body: SafeArea(
            child: StreamBuilder<RestaurantsRecord>(
              stream: RestaurantsRecord.getDocument(widget.restaurant),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: SpinKitThreeBounce(
                        color: FlutterFlowTheme.primaryColor,
                        size: 50,
                      ),
                    ),
                  );
                }
                final columnRestaurantsRecord = snapshot.data;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: DefaultTabController(
                                length: 3,
                                initialIndex: 0,
                                child: Column(
                                  children: [
                                    TabBar(
                                      isScrollable: true,
                                      labelColor: FlutterFlowTheme.primaryColor,
                                      unselectedLabelColor: Colors.white,
                                      labelStyle: GoogleFonts.getFont(
                                        'Roboto',
                                      ),
                                      indicatorColor:
                                          FlutterFlowTheme.primaryColor,
                                      indicatorWeight: 4,
                                      tabs: [
                                        Tab(
                                          text: 'About',
                                        ),
                                        Tab(
                                          text: 'Reviews',
                                        ),
                                        Tab(
                                          text: 'Menu',
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      height: 350,
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                              topLeft: Radius
                                                                  .circular(0),
                                                              topRight: Radius
                                                                  .circular(0),
                                                            ),
                                                            child:
                                                                Image.network(
                                                              valueOrDefault<
                                                                  String>(
                                                                columnRestaurantsRecord
                                                                    .featuredImage,
                                                                'https://media.self.com/photos/5ef3b23e4b76967ef77115e6/4:3/w_2560%2Cc_limit/restaurants_covid.jpg',
                                                              ),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 350,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          250,
                                                                          0,
                                                                          0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                              child: Container(
                                                                                width: 60,
                                                                                height: 60,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF46C632),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 5,
                                                                                      color: Color(0xFF292929),
                                                                                      offset: Offset(2, 2),
                                                                                      spreadRadius: 2,
                                                                                    )
                                                                                  ],
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                                                                    child: Text(
                                                                                      functions.getAverageRating(restaurantDetailsPostsRecordList.toList()),
                                                                                      textAlign: TextAlign.center,
                                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        fontSize: 30,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(2, 4, 0, 0),
                                                                              child: Text(
                                                                                '${columnRestaurantsRecord.reviews.toString()} reviews',
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText1.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: FlutterFlowTheme.tertiaryColor,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                20,
                                                                                20,
                                                                                10,
                                                                                0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                                              height: 40,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.orange,
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    blurRadius: 5,
                                                                                    color: Color(0xFF292929),
                                                                                    offset: Offset(1, 1),
                                                                                    spreadRadius: 1,
                                                                                  )
                                                                                ],
                                                                                borderRadius: BorderRadius.circular(99),
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0, 0),
                                                                                child: Text(
                                                                                  'Diverse',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.bodyText1.override(
                                                                                    fontFamily: 'Lexend Deca',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                20,
                                                                                10,
                                                                                0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                                              height: 40,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.orange,
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    blurRadius: 5,
                                                                                    color: Color(0xFF292929),
                                                                                    offset: Offset(1, 1),
                                                                                    spreadRadius: 1,
                                                                                  )
                                                                                ],
                                                                                borderRadius: BorderRadius.circular(99),
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0, 0),
                                                                                child: Text(
                                                                                  'Comfortable',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.bodyText1.override(
                                                                                    fontFamily: 'Lexend Deca',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10,
                                                                    20, 0, 0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            columnRestaurantsRecord
                                                                .restaurantName,
                                                            'No Restaurant Name',
                                                          ),
                                                          style:
                                                              FlutterFlowTheme
                                                                  .title1
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 5, 0, 10),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        20,
                                                                        0),
                                                            child: AutoSizeText(
                                                              columnRestaurantsRecord
                                                                  .priceRange,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Color(
                                                                    0xFF39D23D),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 300,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .primaryDark,
                                                            ),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                columnRestaurantsRecord
                                                                    .categories,
                                                                '-',
                                                              ),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Color(
                                                                    0xFFA4A4A4),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  columnRestaurantsRecord
                                                                      .restAddress,
                                                                  'No Address',
                                                                ),
                                                                style: FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: FlutterFlowTheme
                                                                      .tertiaryColor,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 10),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          FlutterFlowIconButton(
                                                            borderColor: Colors
                                                                .transparent,
                                                            borderRadius: 30,
                                                            buttonSize: 48,
                                                            icon: Icon(
                                                              Icons
                                                                  .phone_enabled,
                                                              color:
                                                                  Colors.orange,
                                                              size: 30,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await launchURL(
                                                                  'tel:${columnRestaurantsRecord.phoneNumber}');
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          FlutterFlowIconButton(
                                                            borderColor: Colors
                                                                .transparent,
                                                            borderRadius: 30,
                                                            buttonSize: 48,
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .mapMarkedAlt,
                                                              color:
                                                                  Colors.orange,
                                                              size: 30,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await launchURL(
                                                                  functions.getMapUrl(
                                                                      columnRestaurantsRecord
                                                                          .restLatLong));
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          FlutterFlowIconButton(
                                                            borderColor: Colors
                                                                .transparent,
                                                            borderRadius: 30,
                                                            buttonSize: 48,
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .globe,
                                                              color:
                                                                  Colors.orange,
                                                              size: 30,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await launchURL(
                                                                  columnRestaurantsRecord
                                                                      .website);
                                                            },
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x33000000),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  2, 2, 2, 2),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          12,
                                                                          16,
                                                                          0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Text(
                                                                            columnRestaurantsRecord.restSlogan,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                FlutterFlowTheme.title1.override(
                                                                              fontFamily: 'Lexend Deca',
                                                                              color: Color(0xFF0F0F0F),
                                                                              fontSize: 28,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          4,
                                                                          16,
                                                                          12),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      columnRestaurantsRecord
                                                                          .restDescription
                                                                          .maybeHandleOverflow(
                                                                        maxChars:
                                                                            500,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                      style: FlutterFlowTheme
                                                                          .bodyText2
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: Color(
                                                                            0xFF8B97A2),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        10,
                                                                        0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 200,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFEEEEEE),
                                                              ),
                                                              child:
                                                                  FlutterFlowGoogleMap(
                                                                controller:
                                                                    googleMapsController,
                                                                onCameraIdle:
                                                                    (latLng) =>
                                                                        googleMapsCenter =
                                                                            latLng,
                                                                initialLocation:
                                                                    googleMapsCenter ??=
                                                                        columnRestaurantsRecord
                                                                            .restLatLong,
                                                                markers: [
                                                                  if (columnRestaurantsRecord !=
                                                                      null)
                                                                    FlutterFlowMarker(
                                                                      columnRestaurantsRecord
                                                                          .reference
                                                                          .path,
                                                                      columnRestaurantsRecord
                                                                          .restLatLong,
                                                                    ),
                                                                ],
                                                                markerColor:
                                                                    GoogleMarkerColor
                                                                        .orange,
                                                                mapType: MapType
                                                                    .normal,
                                                                style:
                                                                    GoogleMapStyle
                                                                        .dark,
                                                                initialZoom: 16,
                                                                allowInteraction:
                                                                    true,
                                                                allowZoom: true,
                                                                showZoomControls:
                                                                    true,
                                                                showLocation:
                                                                    false,
                                                                showCompass:
                                                                    false,
                                                                showMapToolbar:
                                                                    false,
                                                                showTraffic:
                                                                    true,
                                                                centerMapOnMarkerTap:
                                                                    true,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            10,
                                                                            10,
                                                                            10),
                                                                child: Text(
                                                                  columnRestaurantsRecord
                                                                      .restAddress,
                                                                  style: FlutterFlowTheme
                                                                      .subtitle2
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 20, 0, 0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryDark,
                                                        ),
                                                        child: StreamBuilder<
                                                            List<
                                                                StoriesRecord>>(
                                                          stream:
                                                              queryStoriesRecord(
                                                            queryBuilder: (storiesRecord) => storiesRecord
                                                                .where(
                                                                    'rest_ref',
                                                                    isEqualTo:
                                                                        widget
                                                                            .restaurant)
                                                                .orderBy(
                                                                    'created_time',
                                                                    descending:
                                                                        true),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50,
                                                                  height: 50,
                                                                  child:
                                                                      SpinKitThreeBounce(
                                                                    color: FlutterFlowTheme
                                                                        .primaryColor,
                                                                    size: 50,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<StoriesRecord>
                                                                listViewStoriesRecordList =
                                                                snapshot.data;
                                                            if (listViewStoriesRecordList
                                                                .isEmpty) {
                                                              return Center(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/no_stories_white.png',
                                                                ),
                                                              );
                                                            }
                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  listViewStoriesRecordList
                                                                      .length,
                                                              itemBuilder: (context,
                                                                  listViewIndex) {
                                                                final listViewStoriesRecord =
                                                                    listViewStoriesRecordList[
                                                                        listViewIndex];
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8,
                                                                          0,
                                                                          8,
                                                                          0),
                                                                  child: StreamBuilder<
                                                                      RestaurantsRecord>(
                                                                    stream: RestaurantsRecord.getDocument(
                                                                        columnRestaurantsRecord
                                                                            .reference),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                SpinKitThreeBounce(
                                                                              color: FlutterFlowTheme.primaryColor,
                                                                              size: 50,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      final columnRestaurantsRecord =
                                                                          snapshot
                                                                              .data;
                                                                      return InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          await Navigator
                                                                              .push(
                                                                            context,
                                                                            PageTransition(
                                                                              type: PageTransitionType.bottomToTop,
                                                                              duration: Duration(milliseconds: 200),
                                                                              reverseDuration: Duration(milliseconds: 200),
                                                                              child: StoryDetailsWidget(
                                                                                initialStoryIndex: listViewIndex,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Container(
                                                                              width: 80,
                                                                              height: 80,
                                                                              clipBehavior: Clip.antiAlias,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: valueOrDefault<String>(
                                                                                  columnRestaurantsRecord.logo,
                                                                                  'data:image/jpeg;base64,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',
                                                                                ),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            AutoSizeText(
                                                                              columnRestaurantsRecord.restaurantName.maybeHandleOverflow(
                                                                                maxChars: 12,
                                                                                replacement: '…',
                                                                              ),
                                                                              style: FlutterFlowTheme.bodyText1.override(
                                                                                fontFamily: 'Lexend Deca',
                                                                                color: FlutterFlowTheme.tertiaryColor,
                                                                                fontSize: 12,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ).animated([
                                            animationsMap[
                                                'columnOnPageLoadAnimation']
                                          ]),
                                          SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 40, 0, 0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                          .primaryDark,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 3,
                                                          color:
                                                              Color(0x39000000),
                                                          offset: Offset(0, 1),
                                                        )
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(12, 16,
                                                                  12, 24),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            12),
                                                                child: Text(
                                                                  columnRestaurantsRecord
                                                                      .reviews
                                                                      .toString(),
                                                                  style: FlutterFlowTheme
                                                                      .title1
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                    color: FlutterFlowTheme
                                                                        .tertiaryColor,
                                                                    fontSize:
                                                                        28,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                '# of Reviews',
                                                                style: FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: Color(
                                                                      0xFF95A1AC),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            12),
                                                                    child: Text(
                                                                      functions.getAverageRating(
                                                                          restaurantDetailsPostsRecordList
                                                                              .toList()),
                                                                      style: FlutterFlowTheme
                                                                          .title1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        fontSize:
                                                                            28,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            12),
                                                                    child: Icon(
                                                                      Icons
                                                                          .star_rounded,
                                                                      color: Color(
                                                                          0xFFFFA130),
                                                                      size: 24,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Text(
                                                                'Avg. Rating',
                                                                style: FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: Color(
                                                                      0xFF8B97A2),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                StreamBuilder<
                                                    List<PostsRecord>>(
                                                  stream: queryPostsRecord(
                                                    queryBuilder: (postsRecord) =>
                                                        postsRecord
                                                            .where('rest_ref',
                                                                isEqualTo:
                                                                    columnRestaurantsRecord
                                                                        .reference)
                                                            .orderBy(
                                                                'created_at',
                                                                descending:
                                                                    true),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              SpinKitThreeBounce(
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                            size: 50,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PostsRecord>
                                                        columnPostsRecordList =
                                                        snapshot.data;
                                                    if (columnPostsRecordList
                                                        .isEmpty) {
                                                      return Center(
                                                        child: Image.asset(
                                                          'assets/images/no_video_reviews.png',
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                        ),
                                                      );
                                                    }
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          columnPostsRecordList
                                                              .length,
                                                          (columnIndex) {
                                                        final columnPostsRecord =
                                                            columnPostsRecordList[
                                                                columnIndex];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      2, 2, 2),
                                                          child: StreamBuilder<
                                                              PostsRecord>(
                                                            stream: PostsRecord
                                                                .getDocument(
                                                                    columnPostsRecord
                                                                        .reference),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child:
                                                                        SpinKitThreeBounce(
                                                                      color: FlutterFlowTheme
                                                                          .primaryColor,
                                                                      size: 50,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              final reviewRowPostsRecord =
                                                                  snapshot.data;
                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            10,
                                                                            10,
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.8,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4,
                                                                            color:
                                                                                Color(0x33000000),
                                                                            offset:
                                                                                Offset(0, 2),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(16),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            2,
                                                                            2,
                                                                            2,
                                                                            2),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => NewVideoScreenCopyWidget(
                                                                                  initialStoryIndex: columnIndex,
                                                                                  post: columnPostsRecord.reference,
                                                                                  restaurant: columnRestaurantsRecord,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 40,
                                                                                                height: 40,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0xFFEEEEEE),
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                alignment: AlignmentDirectional(0, 0),
                                                                                                child: Text(
                                                                                                  reviewRowPostsRecord.userRating.toString(),
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: FlutterFlowTheme.title1.override(
                                                                                                    fontFamily: 'Lexend Deca',
                                                                                                    color: Color(0xFF0F0F0F),
                                                                                                    fontSize: 28,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              RatingBarIndicator(
                                                                                                itemBuilder: (context, index) => Icon(
                                                                                                  Icons.star_rounded,
                                                                                                  color: FlutterFlowTheme.secondaryColor,
                                                                                                ),
                                                                                                direction: Axis.horizontal,
                                                                                                rating: reviewRowPostsRecord.userRating,
                                                                                                unratedColor: Color(0xFF9E9E9E),
                                                                                                itemCount: 5,
                                                                                                itemSize: 30,
                                                                                              )
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      StreamBuilder<UsersRecord>(
                                                                                        stream: UsersRecord.getDocument(reviewRowPostsRecord.user),
                                                                                        builder: (context, snapshot) {
                                                                                          // Customize what your widget looks like when it's loading.
                                                                                          if (!snapshot.hasData) {
                                                                                            return Center(
                                                                                              child: SizedBox(
                                                                                                width: 50,
                                                                                                height: 50,
                                                                                                child: SpinKitThreeBounce(
                                                                                                  color: FlutterFlowTheme.primaryColor,
                                                                                                  size: 50,
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          }
                                                                                          final cardUsersRecord = snapshot.data;
                                                                                          return Card(
                                                                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                            color: Color(0xFFDBE2E7),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(40),
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                                                                              child: Container(
                                                                                                width: 50,
                                                                                                height: 50,
                                                                                                clipBehavior: Clip.antiAlias,
                                                                                                decoration: BoxDecoration(
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                child: Image.network(
                                                                                                  cardUsersRecord.photoUrl,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          reviewRowPostsRecord.description.maybeHandleOverflow(
                                                                                            maxChars: 200,
                                                                                            replacement: '…',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.bodyText2.override(
                                                                                            fontFamily: 'Lexend Deca',
                                                                                            color: Color(0xFF8B97A2),
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 60, 0, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 15, 15, 15),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 4,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .primaryDark,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFA4A4A4),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    child: Image
                                                                        .network(
                                                                      'https://static.stacker.com/s3fs-public/2020-07/croppedUntitleddesign20200717T040046THQ4345.png',
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 100,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x820F0F0F),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Breakfast',
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 15, 15, 15),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 4,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .primaryDark,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFA4A4A4),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    child: Image
                                                                        .network(
                                                                      'https://p300-americantownscom.netdna-ssl.com/img/article/in-brunch-spot-1.jpg',
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 100,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x820F0F0F),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Brunch',
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 15, 15, 15),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 4,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .primaryDark,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFA4A4A4),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    child: Image
                                                                        .network(
                                                                      'https://insanelygoodrecipes.com/wp-content/uploads/2020/05/Burger-with-fries-1024x536.png',
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 100,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x820F0F0F),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Lunch',
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 15, 15, 15),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 4,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .primaryDark,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFA4A4A4),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    child: Image
                                                                        .network(
                                                                      'https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/newscms/2019_05/2736521/190131-stock-taco-bar-food-ew-1220p.jpg',
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 100,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x820F0F0F),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Dinner',
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 15, 15, 15),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 4,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .primaryDark,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFA4A4A4),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    child: Image
                                                                        .network(
                                                                      'https://static.toiimg.com/photo/75508582.cms',
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 100,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x820F0F0F),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Dessert',
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.9, -0.84),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                buttonSize: 48,
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.9, -0.8),
                              child: Icon(
                                Icons.bookmark_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.9, -0.8),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 800, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 50,
                                decoration: BoxDecoration(),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    setState(() => _loadingButton = true);
                                    try {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return SubmitReviewWidget(
                                            restaurant: columnRestaurantsRecord,
                                          );
                                        },
                                      );
                                    } finally {
                                      setState(() => _loadingButton = false);
                                    }
                                  },
                                  text: 'Submit Review',
                                  options: FFButtonOptions(
                                    width: 50,
                                    height: 20,
                                    color: FlutterFlowTheme.primaryColor,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 12,
                                  ),
                                  loading: _loadingButton,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

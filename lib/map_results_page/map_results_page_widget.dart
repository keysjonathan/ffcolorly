import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/map_marker_widget.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MapResultsPageWidget extends StatefulWidget {
  MapResultsPageWidget({
    Key key,
    this.restaurant,
  }) : super(key: key);

  final DocumentReference restaurant;

  @override
  _MapResultsPageWidgetState createState() => _MapResultsPageWidgetState();
}

class _MapResultsPageWidgetState extends State<MapResultsPageWidget> {
  LatLng currentUserLocationValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng googleMapsCenter;
  Completer<GoogleMapController> googleMapsController;
  TextEditingController courtSearchFieldController;
  List<RestaurantsRecord> algoliaSearchResults = [];

  @override
  void initState() {
    super.initState();
    courtSearchFieldController = TextEditingController();
    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
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
    return StreamBuilder<List<RestaurantsRecord>>(
      stream: queryRestaurantsRecord(),
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
        List<RestaurantsRecord> mapResultsPageRestaurantsRecordList =
            snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFEFEFEF),
          body: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: FlutterFlowGoogleMap(
                  controller: googleMapsController,
                  onCameraIdle: (latLng) =>
                      setState(() => googleMapsCenter = latLng),
                  initialLocation: googleMapsCenter ??=
                      currentUserLocationValue,
                  markers: (algoliaSearchResults ?? [])
                      .map(
                        (algoliaSearchResultsItem) => FlutterFlowMarker(
                          algoliaSearchResultsItem.reference.path,
                          algoliaSearchResultsItem.restLatLong,
                          () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return MapMarkerWidget();
                              },
                            );
                          },
                        ),
                      )
                      .toList(),
                  markerColor: GoogleMarkerColor.yellow,
                  mapType: MapType.normal,
                  style: GoogleMapStyle.dark,
                  initialZoom: 10,
                  allowInteraction: true,
                  allowZoom: true,
                  showZoomControls: false,
                  showLocation: false,
                  showCompass: false,
                  showMapToolbar: false,
                  showTraffic: true,
                  centerMapOnMarkerTap: true,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1, -1),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [FlutterFlowTheme.primaryDark, Color(0x000F0F0F)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.8),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.tertiaryColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x34000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFA4A4A4),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, -0.3),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                        child: TextFormField(
                          controller: courtSearchFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search restaurants...',
                            hintStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFFA4A4A4),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFFA4A4A4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.89, -0.77),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 130),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.search_outlined,
                      color: FlutterFlowTheme.primaryColor,
                      size: 30,
                    ),
                    onPressed: () async {
                      setState(() => algoliaSearchResults = null);
                      await RestaurantsRecord.search(
                        term: courtSearchFieldController.text,
                      )
                          .then((r) => algoliaSearchResults = r)
                          .onError((_, __) => algoliaSearchResults = [])
                          .whenComplete(() => setState(() {}));
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'What\'s up',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.tertiaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: AuthUserStreamWidget(
                        child: Text(
                          currentUserDisplayName,
                          style: FlutterFlowTheme.title1.override(
                            fontFamily: 'Lexend Deca',
                            color: FlutterFlowTheme.primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

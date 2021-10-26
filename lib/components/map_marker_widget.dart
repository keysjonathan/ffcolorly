import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MapMarkerWidget extends StatefulWidget {
  MapMarkerWidget({
    Key key,
    this.restaurant,
    this.posts,
  }) : super(key: key);

  final RestaurantsRecord restaurant;
  final DocumentReference posts;

  @override
  _MapMarkerWidgetState createState() => _MapMarkerWidgetState();
}

class _MapMarkerWidgetState extends State<MapMarkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: 350,
                  height: 175,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(
                        'https://assets.bonappetit.com/photos/610aa6ddc50e2f9f7c42f7f8/master/pass/Savage-2019-top-50-busy-restaurant.jpg',
                      ).image,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 350,
                            height: 175,
                            decoration: BoxDecoration(
                              color: Color(0xB30F0F0F),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 4,
                                  shape: const CircleBorder(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Stack(
                                          alignment: AlignmentDirectional(0, 0),
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                widget.restaurant.logo,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      widget.restaurant.restaurantName
                                          .maybeHandleOverflow(
                                        maxChars: 18,
                                        replacement: '…',
                                      ),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.tertiaryColor,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.restaurant.restAddress
                                          .maybeHandleOverflow(maxChars: 30),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.tertiaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      widget.restaurant.categories
                                          .maybeHandleOverflow(maxChars: 30),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.secondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${valueOrDefault<String>(
                                        widget.restaurant.reviews.toString(),
                                        '0',
                                      )} reviews'
                                          .maybeHandleOverflow(maxChars: 30),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.tertiaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  buttonSize: 48,
                                  icon: Icon(
                                    Icons.phone_enabled,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    await launchURL(
                                        'tel:${widget.restaurant.phoneNumber}');
                                  },
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  buttonSize: 48,
                                  icon: FaIcon(
                                    FontAwesomeIcons.mapMarkedAlt,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    await launchURL(functions.getMapUrl(
                                        widget.restaurant.restLatLong));
                                  },
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  buttonSize: 48,
                                  icon: FaIcon(
                                    FontAwesomeIcons.globe,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    await launchURL(
                                        'https://${widget.restaurant.website}');
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

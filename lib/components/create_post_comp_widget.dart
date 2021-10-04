import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import '../flutter_flow/upload_media.dart';
import '../main.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostCompWidget extends StatefulWidget {
  CreatePostCompWidget({
    Key key,
    this.restaurantPick,
  }) : super(key: key);

  final DocumentReference restaurantPick;

  @override
  _CreatePostCompWidgetState createState() => _CreatePostCompWidgetState();
}

class _CreatePostCompWidgetState extends State<CreatePostCompWidget> {
  String uploadedFileUrl = '';
  TextEditingController textController2;
  TextEditingController textController1;
  bool switchListTileValue1;
  bool switchListTileValue2;
  var placePickerValue = FFPlace();
  double ratingBarValue;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                  child: Text(
                    'Choose a few qualities!',
                    style: FlutterFlowTheme.subtitle1.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFFF5F5F5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    textController1.text,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200,
                                  decoration: BoxDecoration(),
                                  child: TextFormField(
                                    controller: textController1,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Restaurant',
                                      labelStyle:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
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
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(),
                        child: SwitchListTile.adaptive(
                          value: switchListTileValue1 ??= true,
                          onChanged: (newValue) =>
                              setState(() => switchListTileValue1 = newValue),
                          title: Text(
                            'Diverse',
                            style: FlutterFlowTheme.title3.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                          tileColor: Color(0xFFF5F5F5),
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(),
                        child: SwitchListTile.adaptive(
                          value: switchListTileValue2 ??= true,
                          onChanged: (newValue) =>
                              setState(() => switchListTileValue2 = newValue),
                          title: Text(
                            'Inclusive',
                            style: FlutterFlowTheme.title3.override(
                              fontFamily: 'Roboto',
                            ),
                          ),
                          tileColor: Color(0xFFF5F5F5),
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Hello World',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
              FlutterFlowPlacePicker(
                iOSGoogleMapsApiKey: 'AIzaSyBH1fZaBJ0aBUx4Y6fjsVaEs6cD9FhYgow',
                androidGoogleMapsApiKey:
                    'AIzaSyB8YLpQ-pVGaEOSZEfaoDBbniyzNHREMP0',
                webGoogleMapsApiKey: 'AIzaSyCI7LeCn7jPdiTPwKiLhn6xMxPlcLevReM',
                onSelect: (place) => setState(() => placePickerValue = place),
                defaultText: 'Select Location',
                icon: Icon(
                  Icons.place,
                  color: Colors.white,
                  size: 16,
                ),
                buttonOptions: FFButtonOptions(
                  width: 200,
                  height: 40,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            final selectedMedia =
                                await selectMediaWithSourceBottomSheet(
                              context: context,
                              isVideo: true,
                            );
                            if (selectedMedia != null &&
                                validateFileFormat(
                                    selectedMedia.storagePath, context)) {
                              showUploadMessage(context, 'Uploading file...',
                                  showLoading: true);
                              final downloadUrl = await uploadData(
                                  selectedMedia.storagePath,
                                  selectedMedia.bytes);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (downloadUrl != null) {
                                setState(() => uploadedFileUrl = downloadUrl);
                                showUploadMessage(context, 'Success!');
                              } else {
                                showUploadMessage(
                                    context, 'Failed to upload media');
                                return;
                              }
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.96,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F5F8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/emptyState@2x.png',
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 6,
                                  color: Color(0x3A000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController2,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Share your experience....',
                                  hintStyle:
                                      FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 10,
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
          Text(
            'Rate this Restaurant',
            style: FlutterFlowTheme.subtitle1.override(
              fontFamily: 'Poppins',
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 2, 20, 20),
            child: RatingBar.builder(
              onRatingUpdate: (newValue) => ratingBarValue = newValue,
              itemBuilder: (context, index) => Icon(
                Icons.star_rounded,
                color: Color(0xFFFFC00E),
              ),
              direction: Axis.horizontal,
              initialRating: 0,
              unratedColor: Color(0xFF9E9E9E),
              itemCount: 5,
              itemSize: 40,
              glowColor: Color(0xFFFFC00E),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 20),
            child: FFButtonWidget(
              onPressed: () async {
                final postsCreateData = createPostsRecordData(
                  videoUrl: uploadedFileUrl,
                  descritpion: textController2.text,
                  userRating: ratingBarValue,
                  user: currentUserReference,
                  username: currentUserDisplayName,
                  userProfilePic: currentUserPhoto,
                  createdAt: getCurrentTimestamp,
                  restaurantName: '',
                );
                await PostsRecord.collection.doc().set(postsCreateData);
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    duration: Duration(milliseconds: 2),
                    reverseDuration: Duration(milliseconds: 2),
                    child: NavBarPage(initialPage: 'Home'),
                  ),
                );
              },
              text: 'Create Post',
              options: FFButtonOptions(
                width: 270,
                height: 60,
                color: FlutterFlowTheme.primaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 8,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import '../flutter_flow/upload_media.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostCompWidget extends StatefulWidget {
  CreatePostCompWidget({Key key}) : super(key: key);

  @override
  _CreatePostCompWidgetState createState() => _CreatePostCompWidgetState();
}

class _CreatePostCompWidgetState extends State<CreatePostCompWidget> {
  String choiceChipsValue1;
  String choiceChipsValue2;
  String choiceChipsValue3;
  String choiceChipsValue4;
  String choiceChipsValue5;
  String choiceChipsValue6;
  String uploadedFileUrl = '';
  TextEditingController textController;
  double ratingBarValue;
  var placePickerValue = FFPlace();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
                children: [
                  Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: FlutterFlowChoiceChips(
                        options: [ChipData('Diverse')],
                        onChanged: (val) =>
                            setState(() => choiceChipsValue1 = val),
                        selectedChipStyle: ChipStyle(
                          backgroundColor: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                          iconColor: Colors.white,
                          iconSize: 18,
                          elevation: 4,
                        ),
                        unselectedChipStyle: ChipStyle(
                          backgroundColor: Colors.white,
                          textStyle: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Quicksand',
                            color: FlutterFlowTheme.customColor2,
                          ),
                          iconColor: Color(0xFF262D34),
                          iconSize: 18,
                          elevation: 4,
                        ),
                        chipSpacing: 10,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    child: FlutterFlowChoiceChips(
                      options: [ChipData('Inclusive')],
                      onChanged: (val) =>
                          setState(() => choiceChipsValue2 = val),
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                        iconColor: Colors.white,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor: Colors.white,
                        textStyle: FlutterFlowTheme.bodyText2.override(
                          fontFamily: 'Quicksand',
                          color: FlutterFlowTheme.customColor2,
                        ),
                        iconColor: Color(0xFF262D34),
                        iconSize: 18,
                        elevation: 4,
                      ),
                      chipSpacing: 10,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    child: FlutterFlowChoiceChips(
                      options: [ChipData('Good Food')],
                      onChanged: (val) =>
                          setState(() => choiceChipsValue3 = val),
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                        iconColor: Colors.white,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor: Colors.white,
                        textStyle: FlutterFlowTheme.bodyText2.override(
                          fontFamily: 'Quicksand',
                          color: FlutterFlowTheme.customColor2,
                        ),
                        iconColor: Color(0xFF262D34),
                        iconSize: 18,
                        elevation: 4,
                      ),
                      chipSpacing: 10,
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: FlutterFlowChoiceChips(
                        options: [ChipData('Clean')],
                        onChanged: (val) =>
                            setState(() => choiceChipsValue4 = val),
                        selectedChipStyle: ChipStyle(
                          backgroundColor: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                          iconColor: Colors.white,
                          iconSize: 18,
                          elevation: 4,
                        ),
                        unselectedChipStyle: ChipStyle(
                          backgroundColor: Colors.white,
                          textStyle: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Quicksand',
                            color: FlutterFlowTheme.customColor2,
                          ),
                          iconColor: Color(0xFF262D34),
                          iconSize: 18,
                          elevation: 4,
                        ),
                        chipSpacing: 10,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 165,
                    height: 50,
                    decoration: BoxDecoration(),
                    child: FlutterFlowChoiceChips(
                      options: [ChipData('Highly Reccommend')],
                      onChanged: (val) =>
                          setState(() => choiceChipsValue5 = val),
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                        iconColor: Colors.white,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor: Colors.white,
                        textStyle: FlutterFlowTheme.bodyText2.override(
                          fontFamily: 'Quicksand',
                          color: FlutterFlowTheme.customColor2,
                        ),
                        iconColor: Color(0xFF262D34),
                        iconSize: 18,
                        elevation: 4,
                      ),
                      chipSpacing: 10,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 110,
                    height: 50,
                    decoration: BoxDecoration(),
                    child: FlutterFlowChoiceChips(
                      options: [ChipData('Comfortable')],
                      onChanged: (val) =>
                          setState(() => choiceChipsValue6 = val),
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                        iconColor: Colors.white,
                        iconSize: 18,
                        elevation: 4,
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor: Colors.white,
                        textStyle: FlutterFlowTheme.bodyText2.override(
                          fontFamily: 'Quicksand',
                          color: FlutterFlowTheme.customColor2,
                        ),
                        iconColor: Color(0xFF262D34),
                        iconSize: 18,
                        elevation: 4,
                      ),
                      chipSpacing: 10,
                    ),
                  )
                ],
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
                                controller: textController,
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
              initialRating: 3,
              unratedColor: Color(0xFF9E9E9E),
              itemCount: 5,
              itemSize: 40,
              glowColor: Color(0xFFFFC00E),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: FutureBuilder<List<RestaurantsRecord>>(
              future: RestaurantsRecord.search(
                location: getCurrentUserLocation(),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: SpinKitDualRing(
                        color: Color(0xFFE5831D),
                        size: 50,
                      ),
                    ),
                  );
                }
                List<RestaurantsRecord> placePickerRestaurantsRecordList =
                    snapshot.data;
                // Customize what your widget looks like with no search results.
                if (snapshot.data.isEmpty) {
                  return Container(
                    height: 100,
                    child: Center(
                      child: Text('No results.'),
                    ),
                  );
                }
                return FlutterFlowPlacePicker(
                  iOSGoogleMapsApiKey:
                      '883261131668-itrdu1sc68o6t6iknm47m3bcdsro63v4.apps.googleusercontent.com',
                  androidGoogleMapsApiKey:
                      '883261131668-7e78a18qe34d4u93meumi3niurarvrek.apps.googleusercontent.com',
                  webGoogleMapsApiKey:
                      '883261131668-urqunqqv9aitkrs1h9umuhdd27dguni3.apps.googleusercontent.com',
                  onSelect: (place) => setState(() => placePickerValue = place),
                  defaultText: 'Tag Restaurant',
                  icon: Icon(
                    Icons.place,
                    color: Color(0xFF95A1AC),
                    size: 16,
                  ),
                  buttonOptions: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    borderSide: BorderSide(
                      color: Color(0xFFDBE2E7),
                      width: 2,
                    ),
                    borderRadius: 8,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 20),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
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

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_media_display.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitReviewWidget extends StatefulWidget {
  SubmitReviewWidget({
    Key key,
    this.restaurant,
  }) : super(key: key);

  final RestaurantsRecord restaurant;

  @override
  _SubmitReviewWidgetState createState() => _SubmitReviewWidgetState();
}

class _SubmitReviewWidgetState extends State<SubmitReviewWidget> {
  String uploadedFileUrl1 = '';
  String uploadedFileUrl2 = '';
  TextEditingController textController;
  double ratingBarValue;
  bool _loadingButton = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.tertiaryColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Rate Restaurant',
                    style: FlutterFlowTheme.title3,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Rate the restaurant below.',
                    style: FlutterFlowTheme.bodyText1,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 90,
                    constraints: BoxConstraints(
                      maxWidth: 350,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.primaryDark,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Color(0x2E000000),
                          offset: Offset(0, 4),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0x65000000),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.restaurant.restaurantName,
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Lexend Deca',
                                color: FlutterFlowTheme.tertiaryColor,
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
              padding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'What would you rate this restaurant?',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.bodyText1,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: RatingBar.builder(
                onRatingUpdate: (newValue) =>
                    setState(() => ratingBarValue = newValue),
                itemBuilder: (context, index) => Icon(
                  Icons.star_rounded,
                  color: FlutterFlowTheme.primaryColor,
                ),
                direction: Axis.horizontal,
                initialRating: ratingBarValue ??= 0,
                unratedColor: Color(0xFFA4A4A4),
                itemCount: 5,
                itemPadding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                itemSize: 40,
                glowColor: FlutterFlowTheme.primaryColor,
              ),
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Visibility(
                              visible: functions
                                      .hasUploadedMedia(uploadedFileUrl1) ??
                                  true,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: FlutterFlowMediaDisplay(
                                  path: uploadedFileUrl1,
                                  imageBuilder: (path) => Image.network(
                                    path,
                                    width: 108,
                                    height: 192,
                                    fit: BoxFit.cover,
                                  ),
                                  videoPlayerBuilder: (path) =>
                                      FlutterFlowVideoPlayer(
                                    path: path,
                                    width: 108,
                                    height: 192,
                                    autoPlay: false,
                                    looping: true,
                                    showControls: true,
                                    allowFullScreen: true,
                                    allowPlaybackSpeedMenu: false,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: functions
                                      .hasUploadedMedia(uploadedFileUrl2) ??
                                  true,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                                child: FlutterFlowMediaDisplay(
                                  path: valueOrDefault<String>(
                                    uploadedFileUrl2,
                                    'data:image/jpeg;base64,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',
                                  ),
                                  imageBuilder: (path) => ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      path,
                                      width: 192,
                                      height: 192,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  videoPlayerBuilder: (path) =>
                                      FlutterFlowVideoPlayer(
                                    path: path,
                                    width: 300,
                                    autoPlay: true,
                                    looping: true,
                                    showControls: true,
                                    allowFullScreen: true,
                                    allowPlaybackSpeedMenu: false,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final selectedMedia =
                                          await selectMediaWithSourceBottomSheet(
                                        context: context,
                                        allowPhoto: false,
                                        allowVideo: true,
                                      );
                                      if (selectedMedia != null &&
                                          validateFileFormat(
                                              selectedMedia.storagePath,
                                              context)) {
                                        showUploadMessage(
                                            context, 'Uploading file...',
                                            showLoading: true);
                                        final downloadUrl = await uploadData(
                                            selectedMedia.storagePath,
                                            selectedMedia.bytes);
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        if (downloadUrl != null) {
                                          setState(() =>
                                              uploadedFileUrl1 = downloadUrl);
                                          showUploadMessage(
                                              context, 'Success!');
                                        } else {
                                          showUploadMessage(context,
                                              'Failed to upload media');
                                          return;
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 108,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: FlutterFlowTheme.primaryDark,
                                          width: 2,
                                        ),
                                      ),
                                      child: Image.asset(
                                        'assets/images/upload_video.png',
                                        height: 150,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 6, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          maxWidth: 1000.00,
                                          maxHeight: 1000.00,
                                          allowPhoto: true,
                                        );
                                        if (selectedMedia != null &&
                                            validateFileFormat(
                                                selectedMedia.storagePath,
                                                context)) {
                                          showUploadMessage(
                                              context, 'Uploading file...',
                                              showLoading: true);
                                          final downloadUrl = await uploadData(
                                              selectedMedia.storagePath,
                                              selectedMedia.bytes);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          if (downloadUrl != null) {
                                            setState(() =>
                                                uploadedFileUrl2 = downloadUrl);
                                            showUploadMessage(
                                                context, 'Success!');
                                          } else {
                                            showUploadMessage(context,
                                                'Failed to upload media');
                                            return;
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: FlutterFlowTheme.primaryDark,
                                            width: 2,
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/images/upload_thimbnail.png',
                                          height: 150,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
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
                                  maxLines: 6,
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
              child: FFButtonWidget(
                onPressed: () async {
                  setState(() => _loadingButton = true);
                  try {
                    final postsCreateData = createPostsRecordData(
                      user: currentUserReference,
                      videoUrl: uploadedFileUrl1,
                      restRef: widget.restaurant.reference,
                      description: textController.text,
                      userRating: ratingBarValue,
                      videoThumbnail: uploadedFileUrl2,
                      createdAt: getCurrentTimestamp,
                      isFlagged: false,
                    );
                    await PostsRecord.collection.doc().set(postsCreateData);
                    Navigator.pop(context);
                    final restaurantsUpdateData = {
                      'reviews': FieldValue.increment(1),
                    };
                    await widget.restaurant.reference
                        .update(restaurantsUpdateData);
                  } finally {
                    setState(() => _loadingButton = false);
                  }
                },
                text: 'Submit Rating',
                icon: Icon(
                  Icons.star_outline_rounded,
                  size: 15,
                ),
                options: FFButtonOptions(
                  width: 270,
                  height: 50,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 2,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 8,
                ),
                loading: _loadingButton,
              ),
            )
          ],
        ),
      ),
    );
  }
}

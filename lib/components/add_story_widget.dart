import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_media_display.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../rest_profile_page/rest_profile_page_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AddStoryWidget extends StatefulWidget {
  AddStoryWidget({
    Key key,
    this.restaurant,
    this.user,
  }) : super(key: key);

  final RestaurantsRecord restaurant;
  final UsersRecord user;

  @override
  _AddStoryWidgetState createState() => _AddStoryWidgetState();
}

class _AddStoryWidgetState extends State<AddStoryWidget>
    with TickerProviderStateMixin {
  String uploadedFileUrl = '';
  bool _loadingButton = false;
  TextEditingController campaignNameController;
  TextEditingController websiteController;
  TextEditingController storyDescriptionController;
  final animationsMap = {
    'buttonOnActionTriggerAnimation': AnimationInfo(
      curve: Curves.elasticOut,
      trigger: AnimationTrigger.onActionTrigger,
      duration: 170,
      scale: 0.8,
    ),
  };

  @override
  void initState() {
    super.initState();
    setupTriggerAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onActionTrigger),
      this,
    );

    campaignNameController = TextEditingController();
    websiteController = TextEditingController(text: 'https://');
    storyDescriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                child: Stack(
                  children: [
                    Visibility(
                      visible: !(functions.hasUploadedMedia(uploadedFileUrl)) ??
                          true,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.primaryDark,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/emptyPost@3x.png',
                            ).image,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x2D000000),
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          functions.hasUploadedMedia(uploadedFileUrl) ?? true,
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: FlutterFlowMediaDisplay(
                          path: uploadedFileUrl,
                          imageBuilder: (path) => Image.network(
                            path,
                            width: MediaQuery.of(context).size.width,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
                            path: path,
                            width: MediaQuery.of(context).size.width,
                            autoPlay: false,
                            looping: true,
                            showControls: true,
                            allowFullScreen: true,
                            allowPlaybackSpeedMenu: false,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: TextFormField(
                                  controller: campaignNameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Campaign Name',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hintText: 'Campaign Name',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.primaryDark,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.primaryDark,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: FlutterFlowTheme.tertiaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: TextFormField(
                                  controller: websiteController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Website Link',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hintText: 'Campaign Name',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.primaryDark,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.primaryDark,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: FlutterFlowTheme.tertiaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  keyboardType: TextInputType.url,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      FlutterFlowTheme.primaryDark
                                    ],
                                    stops: [0, 1],
                                    begin: AlignmentDirectional(0, -1),
                                    end: AlignmentDirectional(0, 1),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 1),
                                  child: TextFormField(
                                    controller: storyDescriptionController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Add Comment....',
                                      hintStyle:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.primaryDark,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.primaryDark,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 20, 20, 12),
                                    ),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 4,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                selectedMedia.storagePath, context)) {
                          showUploadMessage(context, 'Uploading file...',
                              showLoading: true);
                          final downloadUrl = await uploadData(
                              selectedMedia.storagePath, selectedMedia.bytes);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF0F0F0F),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.videocam_sharp,
                                color: Color(0xFF0F0F0F),
                                size: 32,
                              ),
                              Text(
                                'Video',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF0F0F0F),
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          setState(() => _loadingButton = true);
                          try {
                            final storiesCreateData = createStoriesRecordData(
                              videoUrl: uploadedFileUrl,
                              restRef: widget.restaurant.reference,
                              comment: storyDescriptionController.text,
                              createdTime: getCurrentTimestamp,
                              isOwner: true,
                              campaignName: campaignNameController.text,
                              userRef: widget.user.reference,
                              linkLearnMore: websiteController.text,
                            );
                            await StoriesRecord.collection
                                .doc()
                                .set(storiesCreateData);
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Nice!'),
                                  content: Text(
                                      'Good thinking getting this thing out there.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(alertDialogContext);
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RestProfilePageWidget(),
                                          ),
                                        );
                                        ;
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } finally {
                            setState(() => _loadingButton = false);
                          }
                        },
                        text: 'Add Story',
                        options: FFButtonOptions(
                          width: 140,
                          height: 50,
                          color: FlutterFlowTheme.primaryColor,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                          ),
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 40,
                        ),
                        loading: _loadingButton,
                      ).animated(
                          [animationsMap['buttonOnActionTriggerAnimation']]),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

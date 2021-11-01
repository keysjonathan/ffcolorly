import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat_user/chat_user_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../following/following_widget.dart';
import '../new_video_screen/new_video_screen_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewProfileOtherWidget extends StatefulWidget {
  ViewProfileOtherWidget({
    Key key,
    this.otherUser,
    this.user,
    this.friends,
  }) : super(key: key);

  final DocumentReference otherUser;
  final UsersRecord user;
  final FriendsRecord friends;

  @override
  _ViewProfileOtherWidgetState createState() => _ViewProfileOtherWidgetState();
}

class _ViewProfileOtherWidgetState extends State<ViewProfileOtherWidget> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.otherUser),
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
        final viewProfileOtherUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.primaryDark,
            automaticallyImplyLeading: true,
            title: Text(
              viewProfileOtherUsersRecord.username,
              style: FlutterFlowTheme.title1.override(
                fontFamily: 'Lexend Deca',
                color: FlutterFlowTheme.tertiaryColor,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                child: InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Confirm'),
                          content: Text('Do you want to block this user?'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(alertDialogContext);
                                Navigator.pop(context);
                                ;
                              },
                              child: Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                    final usersUpdateData = {
                      'blockedUsers': FieldValue.arrayUnion([widget.otherUser]),
                    };
                    await currentUserReference.update(usersUpdateData);
                  },
                  child: Icon(
                    Icons.person_add_disabled_rounded,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 24,
                  ),
                ),
              )
            ],
            centerTitle: true,
            elevation: 4,
          ),
          backgroundColor: FlutterFlowTheme.primaryDark,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(99),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      viewProfileOtherUsersRecord.photoUrl,
                                      'https://p1.pxfuel.com/preview/828/149/229/indistinct-blurred-pineapple-rough.jpg',
                                    ),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                child: Text(
                                  viewProfileOtherUsersRecord.displayName,
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: FlutterFlowTheme.tertiaryColor,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(60, 5, 60, 5),
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
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebookSquare,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: () async {
                                    await launchURL(viewProfileOtherUsersRecord
                                        .facebookUrl);
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
                                    FontAwesomeIcons.instagram,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: () async {
                                    await launchURL(viewProfileOtherUsersRecord
                                        .instagramUrl);
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
                                    FontAwesomeIcons.tiktok,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: () async {
                                    await launchURL(
                                        viewProfileOtherUsersRecord.tiktokUrl);
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
                                    FontAwesomeIcons.link,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: () async {
                                    await launchURL(
                                        viewProfileOtherUsersRecord.website);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(60, 0, 60, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 10),
                                  child: Text(
                                    viewProfileOtherUsersRecord.bio
                                        .maybeHandleOverflow(maxChars: 60),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.tertiaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() => _loadingButton1 = true);
                                  try {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatUserWidget(
                                          chatUser: viewProfileOtherUsersRecord,
                                        ),
                                      ),
                                    );
                                  } finally {
                                    setState(() => _loadingButton1 = false);
                                  }
                                },
                                text: 'Message',
                                options: FFButtonOptions(
                                  width: 90,
                                  height: 40,
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
                                loading: _loadingButton1,
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() => _loadingButton2 = true);
                                  try {
                                    final friendsCreateData =
                                        createFriendsRecordData(
                                      follower: currentUserReference,
                                      followee: widget.otherUser,
                                    );
                                    await FriendsRecord.collection
                                        .doc()
                                        .set(friendsCreateData);

                                    final usersUpdateData = {
                                      'following': FieldValue.arrayUnion(
                                          [widget.otherUser]),
                                    };
                                    await currentUserReference
                                        .update(usersUpdateData);
                                  } finally {
                                    setState(() => _loadingButton2 = false);
                                  }
                                },
                                text: 'Follow',
                                options: FFButtonOptions(
                                  width: 90,
                                  height: 40,
                                  color: Color(0x00E5831D),
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                  ),
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.primaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                                loading: _loadingButton2,
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() => _loadingButton3 = true);
                                  try {
                                    final usersUpdateData = {
                                      'following': FieldValue.arrayRemove(
                                          [widget.otherUser]),
                                    };
                                    await currentUserReference
                                        .update(usersUpdateData);
                                  } finally {
                                    setState(() => _loadingButton3 = false);
                                  }
                                },
                                text: 'Unfollow',
                                options: FFButtonOptions(
                                  width: 90,
                                  height: 40,
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
                                loading: _loadingButton3,
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(60, 0, 46, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 20, 20, 20),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FollowingWidget(
                                        user: viewProfileOtherUsersRecord,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      child: Text(
                                        viewProfileOtherUsersRecord
                                            .following.length
                                            .toString(),
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.tertiaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.tertiaryColor,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(),
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: FlutterFlowTheme.primaryColor,
                                labelStyle: GoogleFonts.getFont(
                                  'Roboto',
                                ),
                                indicatorColor: FlutterFlowTheme.secondaryColor,
                                tabs: [
                                  Tab(
                                    icon: Icon(
                                      Icons.dashboard_rounded,
                                      color: FlutterFlowTheme.primaryColor,
                                    ),
                                  ),
                                  Tab(
                                    icon: FaIcon(
                                      FontAwesomeIcons.fire,
                                      color: Color(0xFFB94600),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    StreamBuilder<List<PostsRecord>>(
                                      stream: queryPostsRecord(
                                        queryBuilder: (postsRecord) => postsRecord
                                            .where('user',
                                                isEqualTo:
                                                    viewProfileOtherUsersRecord
                                                        .reference)
                                            .where('isFlagged',
                                                isEqualTo: false)
                                            .orderBy('created_at',
                                                descending: true),
                                        limit: 12,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: SpinKitThreeBounce(
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                                size: 50,
                                              ),
                                            ),
                                          );
                                        }
                                        List<PostsRecord>
                                            gridViewPostsRecordList =
                                            snapshot.data;
                                        if (gridViewPostsRecordList.isEmpty) {
                                          return Image.asset(
                                            'assets/images/no_video_reviews.png',
                                          );
                                        }
                                        return GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: 0.75,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              gridViewPostsRecordList.length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            final gridViewPostsRecord =
                                                gridViewPostsRecordList[
                                                    gridViewIndex];
                                            return Stack(
                                              children: [
                                                StreamBuilder<PostsRecord>(
                                                  stream:
                                                      PostsRecord.getDocument(
                                                          gridViewPostsRecord
                                                              .reference),
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
                                                    final imagePostsRecord =
                                                        snapshot.data;
                                                    return InkWell(
                                                      onTap: () async {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewVideoScreenWidget(
                                                              post:
                                                                  gridViewPostsRecord
                                                                      .reference,
                                                              initialStoryIndex:
                                                                  gridViewIndex,
                                                              user:
                                                                  viewProfileOtherUsersRecord,
                                                            ),
                                                          ),
                                                        );
                                                        final postsUpdateData =
                                                            {
                                                          'wacthed': FieldValue
                                                              .increment(1),
                                                        };
                                                        await gridViewPostsRecord
                                                            .reference
                                                            .update(
                                                                postsUpdateData);
                                                      },
                                                      child: Image.network(
                                                        gridViewPostsRecord
                                                            .videoThumbnail,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.85, -0.85),
                                                  child: Icon(
                                                    Icons
                                                        .play_circle_outline_rounded,
                                                    color: Color(0xD8FFFFFF),
                                                    size: 24,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0x00960000),
                                                            FlutterFlowTheme
                                                                .primaryDark
                                                          ],
                                                          stops: [0, 1],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  0, -1),
                                                          end:
                                                              AlignmentDirectional(
                                                                  0, 1),
                                                        ),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        2,
                                                                        0,
                                                                        3,
                                                                        0),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_red_eye,
                                                              color: FlutterFlowTheme
                                                                  .tertiaryColor,
                                                              size: 14,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        5,
                                                                        0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                gridViewPostsRecord
                                                                    .wacthed
                                                                    .toString(),
                                                                '0',
                                                              ),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        3,
                                                                        0),
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .fire,
                                                              color: FlutterFlowTheme
                                                                  .tertiaryColor,
                                                              size: 12,
                                                            ),
                                                          ),
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              gridViewPostsRecord
                                                                  .likes.length
                                                                  .toString(),
                                                              '0',
                                                            ),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color: FlutterFlowTheme
                                                                  .tertiaryColor,
                                                              fontSize: 12,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    StreamBuilder<List<PostsRecord>>(
                                      stream: queryPostsRecord(
                                        queryBuilder: (postsRecord) => postsRecord
                                            .where('likes',
                                                arrayContains:
                                                    viewProfileOtherUsersRecord
                                                        .reference)
                                            .where('isFlagged',
                                                isEqualTo: false)
                                            .orderBy('created_at',
                                                descending: true),
                                        limit: 12,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: SpinKitThreeBounce(
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                                size: 50,
                                              ),
                                            ),
                                          );
                                        }
                                        List<PostsRecord>
                                            gridViewPostsRecordList =
                                            snapshot.data;
                                        if (gridViewPostsRecordList.isEmpty) {
                                          return Image.asset(
                                            'assets/images/no_video_reviews.png',
                                          );
                                        }
                                        return GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: 0.75,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              gridViewPostsRecordList.length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            final gridViewPostsRecord =
                                                gridViewPostsRecordList[
                                                    gridViewIndex];
                                            return StreamBuilder<UsersRecord>(
                                              stream: UsersRecord.getDocument(
                                                  gridViewPostsRecord.user),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: SpinKitThreeBounce(
                                                        color: FlutterFlowTheme
                                                            .primaryColor,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final stackUsersRecord =
                                                    snapshot.data;
                                                return Stack(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        final postsUpdateData =
                                                            {
                                                          'wacthed': FieldValue
                                                              .increment(1),
                                                        };
                                                        await gridViewPostsRecord
                                                            .reference
                                                            .update(
                                                                postsUpdateData);
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewVideoScreenWidget(
                                                              initialStoryIndex:
                                                                  gridViewIndex,
                                                              post:
                                                                  gridViewPostsRecord
                                                                      .reference,
                                                              user:
                                                                  stackUsersRecord,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Image.network(
                                                        gridViewPostsRecord
                                                            .videoThumbnail,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.85, -0.85),
                                                      child: Icon(
                                                        Icons
                                                            .play_circle_outline_rounded,
                                                        color:
                                                            Color(0xD8FFFFFF),
                                                        size: 24,
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0x00960000),
                                                                FlutterFlowTheme
                                                                    .primaryDark
                                                              ],
                                                              stops: [0, 1],
                                                              begin:
                                                                  AlignmentDirectional(
                                                                      0, -1),
                                                              end:
                                                                  AlignmentDirectional(
                                                                      0, 1),
                                                            ),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            2,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                child: Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: FlutterFlowTheme
                                                                      .tertiaryColor,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    gridViewPostsRecord
                                                                        .wacthed
                                                                        .toString(),
                                                                    '0',
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                    color: FlutterFlowTheme
                                                                        .tertiaryColor,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            3,
                                                                            0),
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .fire,
                                                                  color: FlutterFlowTheme
                                                                      .tertiaryColor,
                                                                  size: 12,
                                                                ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  gridViewPostsRecord
                                                                      .likes
                                                                      .length
                                                                      .toString(),
                                                                  '0',
                                                                ),
                                                                style: FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: FlutterFlowTheme
                                                                      .tertiaryColor,
                                                                  fontSize: 12,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

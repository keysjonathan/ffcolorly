import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../blocked_users/blocked_users_widget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../following/following_widget.dart';
import '../login/login_widget.dart';
import '../new_video_screen/new_video_screen_widget.dart';
import '../rest_profile_page_copy/rest_profile_page_copy_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileWidget extends StatefulWidget {
  UserProfileWidget({
    Key key,
    this.posts,
    this.user,
    this.friends,
    this.post,
    this.likes,
  }) : super(key: key);

  final DocumentReference posts;
  final UsersRecord user;
  final FriendsRecord friends;
  final PostsRecord post;
  final LikesRecord likes;

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  bool _loadingButton1 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loadingButton2 = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
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
        final userProfileUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.primaryDark,
            automaticallyImplyLeading: true,
            leading: Visibility(
              visible: userProfileUsersRecord.isRestaurant ?? true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                child: FFButtonWidget(
                  onPressed: () async {
                    setState(() => _loadingButton2 = true);
                    try {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestProfilePageCopyWidget(
                            restaurant:
                                userProfileUsersRecord.restaurantConnect,
                            user: userProfileUsersRecord,
                          ),
                        ),
                      );
                    } finally {
                      setState(() => _loadingButton2 = false);
                    }
                  },
                  text: 'Button',
                  icon: Icon(
                    Icons.add_business_rounded,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 24,
                  ),
                  options: FFButtonOptions(
                    width: 60,
                    height: 50,
                    color: FlutterFlowTheme.primaryColor,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                    ),
                    elevation: 6,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                  loading: _loadingButton2,
                ),
              ),
            ),
            title: Text(
              userProfileUsersRecord.username,
              style: FlutterFlowTheme.title1.override(
                fontFamily: 'Lexend Deca',
                color: FlutterFlowTheme.tertiaryColor,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlockedUsersWidget(
                          user: userProfileUsersRecord,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.person_add_disabled,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: InkWell(
                  onTap: () async {
                    await signOut();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginWidget(),
                      ),
                      (r) => false,
                    );
                  },
                  child: Icon(
                    Icons.logout,
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
                                      userProfileUsersRecord.photoUrl,
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
                                  userProfileUsersRecord.displayName,
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
                                    await launchURL(
                                        userProfileUsersRecord.facebookUrl);
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
                                    await launchURL(
                                        userProfileUsersRecord.instagramUrl);
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
                                        userProfileUsersRecord.tiktokUrl);
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
                                        userProfileUsersRecord.website);
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
                                    userProfileUsersRecord.bio
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(95, 0, 95, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton1 = true);
                            try {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileWidget(
                                    user: userProfileUsersRecord,
                                  ),
                                ),
                              );
                            } finally {
                              setState(() => _loadingButton1 = false);
                            }
                          },
                          text: 'Edit Profile',
                          options: FFButtonOptions(
                            width: 40,
                            height: 46,
                            color: Colors.black,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0x77FFFFFF),
                              fontSize: 18,
                            ),
                            borderSide: BorderSide(
                              color: Color(0x8BF1F1F1),
                              width: 1,
                            ),
                            borderRadius: 8,
                          ),
                          loading: _loadingButton1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(60, 0, 46, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                        user: userProfileUsersRecord,
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
                                        userProfileUsersRecord.following.length
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
                                        queryBuilder: (postsRecord) =>
                                            postsRecord
                                                .where('user',
                                                    isEqualTo:
                                                        currentUserReference)
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
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NewVideoScreenWidget(
                                                                initialStoryIndex:
                                                                    gridViewIndex,
                                                                post: gridViewPostsRecord
                                                                    .reference,
                                                                user:
                                                                    stackUsersRecord,
                                                              ),
                                                            ),
                                                          );
                                                          final postsUpdateData =
                                                              {
                                                            'wacthed':
                                                                FieldValue
                                                                    .increment(
                                                                        1),
                                                          };
                                                          await gridViewPostsRecord
                                                              .reference
                                                              .update(
                                                                  postsUpdateData);
                                                        },
                                                        child: Image.network(
                                                          gridViewPostsRecord
                                                              .videoThumbnail,
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.85, -0.85),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .playCircle,
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
                                                                  gridViewPostsRecord
                                                                      .wacthed
                                                                      .toString(),
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
                                                                gridViewPostsRecord
                                                                    .likes
                                                                    .length
                                                                    .toString(),
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
                                                    ),
                                                    Visibility(
                                                      visible:
                                                          gridViewPostsRecord
                                                                  .isFlagged ??
                                                              true,
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidEyeSlash,
                                                        color: FlutterFlowTheme
                                                            .secondaryColor,
                                                        size: 24,
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    StreamBuilder<List<PostsRecord>>(
                                      stream: queryPostsRecord(
                                        queryBuilder: (postsRecord) =>
                                            postsRecord
                                                .where('likes',
                                                    arrayContains:
                                                        currentUserReference)
                                                .where('isFlagged',
                                                    isEqualTo: false)
                                                .orderBy('created_at',
                                                    descending: true),
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
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewVideoScreenWidget(
                                                              post:
                                                                  gridViewPostsRecord
                                                                      .reference,
                                                              user:
                                                                  stackUsersRecord,
                                                              initialStoryIndex:
                                                                  gridViewIndex,
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

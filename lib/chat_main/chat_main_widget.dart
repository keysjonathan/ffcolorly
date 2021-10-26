import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat_user/chat_user_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMainWidget extends StatefulWidget {
  ChatMainWidget({
    Key key,
    this.user,
  }) : super(key: key);

  final UsersRecord user;

  @override
  _ChatMainWidgetState createState() => _ChatMainWidgetState();
}

class _ChatMainWidgetState extends State<ChatMainWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryDark,
        automaticallyImplyLeading: false,
        title: Text(
          'Chat',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
            color: FlutterFlowTheme.tertiaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
          child: StreamBuilder<List<ChatsRecord>>(
            stream: queryChatsRecord(
              queryBuilder: (chatsRecord) => chatsRecord
                  .where('users', arrayContains: currentUserReference)
                  .orderBy('last_message_time', descending: true),
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
              List<ChatsRecord> listViewChatsRecordList = snapshot.data;
              if (listViewChatsRecordList.isEmpty) {
                return Center(
                  child: Image.asset(
                    'assets/images/no_messages.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: listViewChatsRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewChatsRecord =
                      listViewChatsRecordList[listViewIndex];
                  return FutureBuilder<UsersRecord>(
                    future: () async {
                      final chatUserRef = FFChatManager.instance.getChatUserRef(
                          currentUserReference, listViewChatsRecord);
                      return UsersRecord.getDocument(chatUserRef).first;
                    }(),
                    builder: (context, snapshot) {
                      final chatUser = snapshot.data;
                      return FFChatPreview(
                        onTap: chatUser != null
                            ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatUserWidget(
                                      chatUser: chatUser,
                                    ),
                                  ),
                                )
                            : null,
                        lastChatText: listViewChatsRecord.lastMessage,
                        lastChatTime: listViewChatsRecord.lastMessageTime,
                        seen: listViewChatsRecord.lastMessageSeenBy
                            .contains(currentUserReference),
                        userName: chatUser?.displayName ?? '',
                        userProfilePic: chatUser?.photoUrl ?? '',
                        color: FlutterFlowTheme.tertiaryColor,
                        unreadColor: FlutterFlowTheme.primaryColor,
                        titleTextStyle: GoogleFonts.getFont(
                          'Lexend Deca',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                        ),
                        dateTextStyle: GoogleFonts.getFont(
                          'Lexend Deca',
                          color: Color(0xFFA4A4A4),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        previewTextStyle: GoogleFonts.getFont(
                          'Lexend Deca',
                          color: Color(0xFFA4A4A4),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(12, 3, 3, 3),
                        borderRadius: BorderRadius.circular(0),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MultipleRestListWidget extends StatefulWidget {
  MultipleRestListWidget({Key key}) : super(key: key);

  @override
  _MultipleRestListWidgetState createState() => _MultipleRestListWidgetState();
}

class _MultipleRestListWidgetState extends State<MultipleRestListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: StreamBuilder<List<RestaurantsRecord>>(
          stream: queryRestaurantsRecord(
            queryBuilder: (restaurantsRecord) => restaurantsRecord
                .where('userConnection', isEqualTo: currentUserReference),
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SpinKitThreeBounce(
                    color: FlutterFlowTheme.primaryColor,
                    size: 30,
                  ),
                ),
              );
            }
            List<RestaurantsRecord> columnRestaurantsRecordList = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(columnRestaurantsRecordList.length,
                    (columnIndex) {
                  final columnRestaurantsRecord =
                      columnRestaurantsRecordList[columnIndex];
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      columnRestaurantsRecord.restaurantName,
                                      style: FlutterFlowTheme.title3.override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.tertiaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 40,
                          fillColor: Color(0x41000000),
                          icon: Icon(
                            Icons.close_rounded,
                            color: FlutterFlowTheme.primaryDark,
                            size: 20,
                          ),
                          onPressed: () async {
                            final usersUpdateData = {
                              'uid': FieldValue.delete(),
                            };
                            await columnRestaurantsRecord.userConnection
                                .update(usersUpdateData);
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Confirm'),
                                  content: Text(
                                      'Are you sure you want to delete your connection?'),
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
                          },
                        )
                      ],
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}

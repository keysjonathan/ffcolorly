import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteStoryWidget extends StatefulWidget {
  DeleteStoryWidget({
    Key key,
    this.storyParameter,
  }) : super(key: key);

  final StoriesRecord storyParameter;

  @override
  _DeleteStoryWidgetState createState() => _DeleteStoryWidgetState();
}

class _DeleteStoryWidgetState extends State<DeleteStoryWidget> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 200,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.primaryDark,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FFButtonWidget(
              onPressed: () async {
                setState(() => _loadingButton1 = true);
                try {
                  await widget.storyParameter.reference.delete();
                  Navigator.pop(context);
                } finally {
                  setState(() => _loadingButton1 = false);
                }
              },
              text: 'Delete Story',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60,
                color: FlutterFlowTheme.primaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 40,
              ),
              loading: _loadingButton1,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  setState(() => _loadingButton2 = true);
                  try {
                    Navigator.pop(context);
                  } finally {
                    setState(() => _loadingButton2 = false);
                  }
                },
                text: 'Cancel',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60,
                  color: Color(0xFF2F2F2F),
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 40,
                ),
                loading: _loadingButton2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

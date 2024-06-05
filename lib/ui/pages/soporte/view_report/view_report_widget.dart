import 'package:get/get.dart';

import '../../../flutter_flow/flutter_flow_animations.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'view_report_model.dart';
export 'view_report_model.dart';

import '../../../../domain/entities/user_support.dart';
import '../../../controllers/report_controller.dart';
import '../../../components/us_report_list.dart';

class ViewReportWidget extends StatefulWidget {
  const ViewReportWidget(this.user, {Key? key}) : super(key: key);

  final UserSupport user;

  @override
  State<ViewReportWidget> createState() => _ViewReportWidgetState();
}

class _ViewReportWidgetState extends State<ViewReportWidget>
    with TickerProviderStateMixin {
  late ViewReportModel _model;
  ReportController reportController = Get.find();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewReportModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user; // Acceder al parámetro user del widget
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Page Title',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                  child: _getxucreportlistview(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Get.toNamed('/create_report', arguments: user.id);
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 60.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getxucreportlistview() {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          await reportController.getReports();
        },
        
        child: ListView.builder(
          itemCount: reportController.reports
              .where((report) => report.id_support == widget.user.id)
              .length,
          itemBuilder: (context, index) {
            final filteredReports = reportController.reports
                .where((report) => report.id_support == widget.user.id)
                .toList();
            final entry = filteredReports[index];
            return usReportList(entry);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_flutter_admin/domain/entities/report.dart';
import '../components/action2_sheet_simple_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/form_field_controller.dart';

import '../controllers/normal_user_controller.dart';
import '../controllers/report_controller.dart';

class usReportList extends StatelessWidget {
  final Report entry;
  const usReportList(this.entry, {Key? key}) : super(key: key);

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Action2SheetSimpleWidget(
          onRatingSubmitted: (exit) {
            ReportController reportController = Get.find();
            // Handle the option logic
            switch (exit) {
              case 'Edit':
                print('Edit option selected');
                break;
              case 'Delete':
                reportController.deleteReport(entry.id!);
                print('Delete option selected');
                break;
              case 'Cancel':
                print('Cancel option selected');
                break;
              default:
                // Handle unexpected value
                print('Unknown option selected: $exit');
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    NormalUserController normal_userController = Get.find();
    int id = entry.id ?? 0;
    normal_userController.getNormalUser(id);

    return GestureDetector(
      onTap: () => _showRatingDialog(context),
      child: Container(
        
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 0.0,
              color: FlutterFlowTheme.of(context).alternate,
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
          child: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: Color(0xFF4B39EF),
                  size: 24.0,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      normal_userController.normal_user?.name ?? "SomeName",
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      'Report Id: $id',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Calification',
                            style:
                                FlutterFlowTheme.of(context).labelSmall.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                          ),
                          Text(
                            entry.calification != 0
                                ? entry.calification.toString()
                                : '-',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'client: ${normal_userController.normal_user?.name ?? "SomeName"}',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Text(
                          'Client id: ${entry.id_client.toString()}',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Text(
                          'date: ${entry.time_started}',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Text(
                        entry.problem,
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                    Text(
                      'end time: ${entry.time_end}',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

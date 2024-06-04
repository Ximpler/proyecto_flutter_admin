import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../controllers/auth_controller.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController()); // Agrega esta línea

    return GestureDetector(
      onTap: () => authController.emailFocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(authController.emailFocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: 100.0,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 44.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 602.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16.0),
                                bottomRight: Radius.circular(16.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                            alignment: AlignmentDirectional(-1.0, 0.0),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 700.0,
                          constraints: BoxConstraints(
                            maxWidth: 602.0,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment:
                                        AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              12.0, 0.0, 12.0, 12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 12.0, 0.0, 24.0),
                                            child: Text(
                                              'Let\'s get started by filling out the form below.',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily:
                                                        'Readex Pro',
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 0.0, 0.0, 16.0),
                                            child: Container(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller: authController
                                                    .emailController,
                                                focusNode: authController
                                                    .emailFocusNode,
                                                autofocus: true,
                                                autofillHints: [
                                                  AutofillHints.email
                                                ],
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            letterSpacing:
                                                                0.0,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .alternate,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: FlutterFlowTheme
                                                          .of(context)
                                                      .secondaryBackground,
                                                  contentPadding:
                                                      EdgeInsets.all(24.0),
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          'Readex Pro',
                                                      letterSpacing: 0.0,
                                                    ),
                                                keyboardType: TextInputType
                                                    .emailAddress,
                                                cursorColor:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 0.0, 0.0, 16.0),
                                            child: Container(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller: authController
                                                    .passwordController,
                                                focusNode: authController
                                                    .passwordFocusNode,
                                                autofocus: false,
                                                autofillHints: [
                                                  AutofillHints.password
                                                ],
                                                obscureText: !authController
                                                    .passwordVisibility
                                                    .value,
                                                decoration: InputDecoration(
                                                  labelText: 'Password',
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            letterSpacing:
                                                                0.0,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .alternate,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(40.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: FlutterFlowTheme
                                                          .of(context)
                                                      .secondaryBackground,
                                                  contentPadding:
                                                      EdgeInsets.all(24.0),
                                                  suffixIcon: Obx(
                                                    () => InkWell(
                                                      onTap: () =>
                                                          authController
                                                              .passwordVisibility
                                                              .toggle(),
                                                      focusNode: FocusNode(
                                                          skipTraversal:
                                                              true),
                                                      child: Icon(
                                                        authController
                                                                .passwordVisibility
                                                                .value
                                                            ? Icons
                                                                .visibility_outlined
                                                            : Icons
                                                                .visibility_off_outlined,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          'Readex Pro',
                                                      letterSpacing: 0.0,
                                                    ),
                                                cursorColor:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 16.0),
                                              child: FFButtonWidget(
                                                onPressed:
                                                    authController.login,
                                                text: 'Sign In',
                                                options: FFButtonOptions(
                                                  width: 230.0,
                                                  height: 52.0,
                                                  padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                  color:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors
                                                                .white,
                                                            letterSpacing:
                                                                0.0,
                                                          ),
                                                  elevation: 3.0,
                                                  borderSide: BorderSide(
                                                    color:
                                                        Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  flex: 6,
                  child: Container(
                    width: 100.0,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          'https://images.unsplash.com/photo-1508385082359-f38ae991e8f2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

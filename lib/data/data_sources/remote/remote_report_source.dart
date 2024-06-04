import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/report.dart';
import 'package:http/http.dart' as http;

import 'i_remote_report_source.dart';

class RemoteReportSource implements IRemoteReportSource {
  final http.Client httpClient;
  final String apiKey = 'oDnY5J';
  
  RemoteReportSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<Report>> getReports() async {
    List<Report> reports = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/reports")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await httpClient.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      reports = List<Report>.from(data.skip(1).map((x) => Report.fromJson(x)));
      //reports.removeAt(1);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(reports);
  }

  @override
  Future<bool> addReport(Report report_support) async {
    logInfo("Web service, Adding report_support");

    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/reports"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(report_support.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      logError(response.body);
      return Future.value(false);
    }
  }

  @override
  Future<bool> updateReport(Report report_support) async {
    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/reports/${report_support.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(report_support.toJson()),
    );

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteReport(int id) async {
    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/reports/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    logInfo("Deleting report_support with id $id status code ${response.statusCode}");
    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteReports() async {
    List<Report> reports = await getReports();
    for (var report_support in reports) {
      await deleteReport(report_support.id!);
    }
    return Future.value(true);
  }
}
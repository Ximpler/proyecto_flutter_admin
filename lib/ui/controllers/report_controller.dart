import 'package:proyecto_flutter_admin/ui/controllers/connectivity_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/report.dart';
import '../../domain/use_cases/report_usecase.dart';

class ReportController extends GetxController {
  final RxList<Report> _reports = <Report>[].obs;
  final ReportUseCase reportUseCase = Get.find();
  final ConnectivityController connectivity = Get.find();

  List<Report> get reports => _reports;

  @override
  void onInit() {
    getReports();
    super.onInit();
  }

  Future<void> getReports() async {
    logInfo("Getting reports");
    _reports.value = await reportUseCase.getReports();
  }

  Future<void> addReport(Report report) async {
    logInfo("Add report");
    await reportUseCase.addReport(report);
    getReports();
  }

  Future<void> updateReport(Report report) async {
    logInfo("Update report");
    await reportUseCase.updateReport(report);
    getReports();
  }

  Future<void> deleteReport(int id) async {
    logInfo("deleteReport report $id");
    await reportUseCase.deleteReport(id);
    getReports();
  }

  Future<void> deleteReports() async {
    logInfo("deleteReports");
    await reportUseCase.deleteReports();
    getReports();
  }
}

import 'package:proyecto_flutter_admin/data/data_sources/local/i_local_report_datasource.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/i_report_repository.dart';
import '../core/network_info.dart';
import '../data_sources/remote/i_remote_report_source.dart';

class ReportRepository implements IReportRepository {
  final IRemoteReportSource _reportDatatasource;
  final ILocalReportDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  ReportRepository(
      this._reportDatatasource, this._localDataSource, this._networkInfo);

  @override
  Future<List<Report>> getReports() async {
    if (await _networkInfo.isConnected()) {
      logInfo("getReports online");
      // Get offline reports and add them to the backend
      final offLineReports = await _localDataSource.getOfflineReports();
      if (offLineReports.isNotEmpty) {
        logInfo("getReports found ${offLineReports.length} offline reports");
        for (var report in offLineReports) {
          var rta = await _reportDatatasource.addReport(report);
          if (rta) {
            await _localDataSource.deleteOfflineEntry(report);
          } else {
            logError("getReports error adding offline report");
          }
        }
      }
      // Get reports from backend
      final reports = await _reportDatatasource.getReports();
      logInfo("getReports online reports: ${reports.length}");
      await _localDataSource.cacheReports(reports);
      return reports;
    }
    // Get offline reports
    logInfo("getReports offline");
    return await _localDataSource.getCachedReports() +
        await _localDataSource.getOfflineReports();
  }

  @override
  Future<bool> addReport(Report report) async {
    if (await _networkInfo.isConnected()) {
      await _reportDatatasource.addReport(report);
    } else {
      await _localDataSource.addOfflineReport(report);
    }
    return true;
  }

  @override
  Future<bool> updateReport(Report report) async {
    if (await _networkInfo.isConnected()) {
      await _reportDatatasource.updateReport(report);
    } else {
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteReport(int id) async {
    if (await _networkInfo.isConnected()) {
      await _reportDatatasource.deleteReport(id);
    } else {
      return false;
    }
    return true;
  }

  @override
  Future<void> deleteReports() async {
    await _localDataSource.deleteReports();
    if (await _networkInfo.isConnected()) {
      await _reportDatatasource.deleteReports();
    }
  }
}
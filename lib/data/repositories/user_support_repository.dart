import 'package:proyecto_flutter_admin/data/data_sources/local/i_local_user_support_datasource.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/user_support.dart';
import '../../domain/repositories/i_user_support_repository.dart';
import '../core/network_info.dart';
import '../data_sources/remote/i_remote_user_support_source.dart';

class UserSupportRepository implements IUserSupportRepository {
  final IRemoteUserSupportSource _user_supportDatatasource;
  final ILocalUserSupportDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  UserSupportRepository(
      this._user_supportDatatasource, this._localDataSource, this._networkInfo);

  @override
  Future<List<UserSupport>> getUserSupports() async {
    const int maxRetries = 4;
    const Duration retryDelay = Duration(milliseconds: 50);

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      bool connected = await _networkInfo.isConnected();
      logInfo(
          "UserSupportRepository: getUserSupports() - attempt $attempt, connected: $connected");

      if (connected) {
        logInfo("getUserSupports online");
        // Get offline user_supports and add them to the backend
        final offLineUserSupports = await _localDataSource.getOfflineUserSupports();
        if (offLineUserSupports.isNotEmpty) {
          logInfo("getUserSupports found ${offLineUserSupports.length} offline user_supports");
          for (var user_support in offLineUserSupports) {
            var rta = await _user_supportDatatasource.addUserSupport(user_support);
            if (rta) {
              await _localDataSource.deleteOfflineEntry(user_support);
            } else {
              logError("getUserSupports error adding offline user_support");
            }
          }
        }
        // Get user_supports from backend
        final user_supports = await _user_supportDatatasource.getUserSupports();
        logInfo("getUserSupports online user_supports: ${user_supports.length}");
        await _localDataSource.cacheUserSupports(user_supports);
        return user_supports;
      }

      // Wait before next attempt
      await Future.delayed(retryDelay);
    }
    // Get offline user_supports
    logInfo("getUserSupports offline");
    return await _localDataSource.getCachedUserSupports() +
        await _localDataSource.getOfflineUserSupports();
  }

  @override
  Future<bool> addUserSupport(UserSupport user_support) async {
    if (await _networkInfo.isConnected()) {
      await _user_supportDatatasource.addUserSupport(user_support);
    } else {
      await _localDataSource.addOfflineUserSupport(user_support);
    }
    return true;
  }

  @override
  Future<bool> updateUserSupport(UserSupport user_support) async {
    if (await _networkInfo.isConnected()) {
      await _user_supportDatatasource.updateUserSupport(user_support);
    } else {
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteUserSupport(int id) async {
    if (await _networkInfo.isConnected()) {
      await _user_supportDatatasource.deleteUserSupport(id);
    } else {
      return false;
    }
    return true;
  }

  @override
  Future<void> deleteUserSupports() async {
    await _localDataSource.deleteUserSupports();
    if (await _networkInfo.isConnected()) {
      await _user_supportDatatasource.deleteUserSupports();
    }
  }
}

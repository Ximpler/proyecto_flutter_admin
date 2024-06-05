import 'package:proyecto_flutter_admin/data/models/user_support_db.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/user_support.dart';
import 'i_local_user_support_datasource.dart';

class LocalUserSupportSource implements ILocalUserSupportDataSource {
  @override
  Future<List<UserSupport>> getCachedUserSupports() async {
    logInfo('getCachedUserSupports ${Hive.box('user_supportDb').values.length}');
    return Hive.box('user_supportDb')
        .values
        .map((entry) => UserSupport(
              id: entry.key,
              name: entry.name,
              email: entry.email,
              password: entry.password,
            ))
        .toList();
  }

  @override
  Future<void> deleteUserSupports() async {
    await Hive.box('user_supportDb').clear();
    await Hive.box('user_supportDbOffline').clear();
  }

  @override
  Future<void> deleteOfflineEntry(UserSupport entry) async {
    await Hive.box('user_supportDbOffline').delete(entry.id);
  }

  @override
  Future<void> addOfflineUserSupport(UserSupport entry) async {
    logInfo("Adding addOfflineUserSupport");
    await Hive.box('user_supportDbOffline').add(UserSupportDb(
              name: entry.name,
              email: entry.email,
              password: entry.password));
    logInfo('addOfflineUserSupport ${Hive.box('user_supportDbOffline').values.length}');
  }

  @override
  Future<void> cacheUserSupports(List<UserSupport> user_supports) async {
    logInfo('pre-cacheUserSupports ${Hive.box('user_supportDb').values.length}');
    await Hive.box('user_supportDb').clear();
    logInfo('pre-cacheUserSupports ${Hive.box('user_supportDb').values.length}');
    for (var user_support in user_supports) {
      await Hive.box('user_supportDb').add(UserSupportDb(
              name: user_support.name,
              email: user_support.email,
              password: user_support.password,));
    }
    logInfo('cacheUserSupports ${Hive.box('user_supportDb').values.length}');
  }

  @override
  Future<List<UserSupport>> getOfflineUserSupports() async {
    logInfo('getOfflineUserSupports ${Hive.box('user_supportDbOffline').values.length}');
    return Hive.box('user_supportDbOffline')
        .values
        .map((entry) => UserSupport(
            id: entry.key,
              name: entry.name,
              email: entry.email,
              password: entry.password,))
        .toList();
  }

  @override
  Future<void> clearOfflineUserSupports() async {
    await Hive.box('user_supportDbOffline').clear();
  }
}

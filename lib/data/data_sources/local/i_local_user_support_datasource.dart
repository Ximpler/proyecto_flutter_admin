import '../../../domain/entities/user_support.dart';

abstract class ILocalUserSupportDataSource {
  Future<void> addOfflineUserSupport(UserSupport entry);

  Future<List<UserSupport>> getCachedUserSupports();

  Future<void> deleteUserSupports();

  Future<void> deleteOfflineEntry(UserSupport entry);

  Future<void> cacheUserSupports(List<UserSupport> user_supports);

  Future<List<UserSupport>> getOfflineUserSupports();

  Future<void> clearOfflineUserSupports();
}
import 'package:loggy/loggy.dart';
import '../../domain/entities/normal_user.dart';
import '../../domain/repositories/i_normal_user_repository.dart';
import '../data_sources/remote/i_remote_normal_user_source.dart';

class NormalUserRepository implements INormalUserRepository {
  final IRemoteNormalUserSource _normalUserDataSource;

  NormalUserRepository(this._normalUserDataSource);

  @override
  Future<List<NormalUser>> getNormalUsers() async {
    try {
      // Get normal_users from backend
      final normalUsers = await _normalUserDataSource.getNormalUsers();
      logInfo("getNormalUsers online normal_users: ${normalUsers.length}");
      return normalUsers;
    } catch (e) {
      logError("Error in getNormalUsers: $e");
      // Return an empty list or handle the error as needed
      return [];
    }
  }

  @override
  Future<NormalUser> getNormalUser(id) async {
    try {
      // Get normal_users from backend
      final normalUser = await _normalUserDataSource.getNormalUser(id);
      logInfo("getNormalUser online normal_user name: ${normalUser.name}");
      return normalUser;
    } catch (e) {
      logError("Error in getNormalUsers: $e");
      // Return an empty list or handle the error as needed
      return NormalUser(name: "SomeName");
    }
  }

  @override
  Future<bool> addNormalUser(NormalUser normalUser) async {
    try {
      await _normalUserDataSource.addNormalUser(normalUser);
      return true;
    } catch (e) {
      logError("Error in addNormalUser: $e");
      return false;
    }
  }

  @override
  Future<bool> updateNormalUser(NormalUser normalUser) async {
    try {
      await _normalUserDataSource.updateNormalUser(normalUser);
      return true;
    } catch (e) {
      logError("Error in updateNormalUser: $e");
      return false;
    }
  }

  @override
  Future<bool> deleteNormalUser(int id) async {
    try {
      await _normalUserDataSource.deleteNormalUser(id);
      return true;
    } catch (e) {
      logError("Error in deleteNormalUser: $e");
      return false;
    }
  }

  @override
  Future<void> deleteNormalUsers() async {
    try {
      await _normalUserDataSource.deleteNormalUsers();
    } catch (e) {
      logError("Error in deleteNormalUsers: $e");
    }
  }
}

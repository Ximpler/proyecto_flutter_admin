import '../../../domain/entities/user_support.dart';

abstract class IRemoteUserSupportSource {
  Future<List<UserSupport>> getUsers();

  Future<bool> addUser(UserSupport user);

  Future<bool> updateUser(UserSupport user);

  Future<bool> deleteUser(int id);

  Future<bool> deleteUsers();
}
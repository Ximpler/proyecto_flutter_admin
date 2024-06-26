import '../../../domain/entities/user_support.dart';

abstract class IRemoteUserSupportSource {
  Future<List<UserSupport>> getUserSupports();

  Future<bool> addUserSupport(UserSupport user_support);

  Future<bool> updateUserSupport(UserSupport user_support);

  Future<bool> deleteUserSupport(int id);

  Future<bool> deleteUserSupports();
}
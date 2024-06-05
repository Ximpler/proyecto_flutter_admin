import '../entities/user_support.dart';

abstract class IUserSupportRepository {
  Future<List<UserSupport>> getUserSupports();

  Future<bool> addUserSupport(UserSupport user_support);

  Future<bool> updateUserSupport(UserSupport user_support);

  Future<bool> deleteUserSupport(int id);

  Future<void> deleteUserSupports();
}
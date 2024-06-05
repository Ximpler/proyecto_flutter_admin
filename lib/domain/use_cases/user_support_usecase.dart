import '../entities/user_support.dart';
import '../repositories/i_user_support_repository.dart';

class UserSupportUseCase {
  final IUserSupportRepository _repository;

  UserSupportUseCase(this._repository);

  Future<List<UserSupport>> getUserSupports() async => await _repository.getUserSupports();

  Future<bool> addUserSupport(UserSupport user_support) async => await _repository.addUserSupport(user_support);

  Future<bool> updateUserSupport(UserSupport user_support) async =>
      await _repository.updateUserSupport(user_support);

  Future<bool> deleteUserSupport(int id) async => await _repository.deleteUserSupport(id);

  Future<void> deleteUserSupports() async => await _repository.deleteUserSupports();
}
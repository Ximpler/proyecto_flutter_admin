import '../entities/normal_user.dart';
import '../repositories/i_normal_user_repository.dart';

class NormalUserUseCase {
  final INormalUserRepository _repository;

  NormalUserUseCase(this._repository);

  Future<List<NormalUser>> getNormalUsers() async => await _repository.getNormalUsers();

  Future<NormalUser> getNormalUser(int id) async => await _repository.getNormalUser(id);

  Future<bool> addNormalUser(NormalUser normal_user) async => await _repository.addNormalUser(normal_user);

  Future<bool> updateNormalUser(NormalUser normal_user) async =>
      await _repository.updateNormalUser(normal_user);

  Future<bool> deleteNormalUser(int id) async => await _repository.deleteNormalUser(id);

  Future<void> deleteNormalUsers() async => await _repository.deleteNormalUsers();
}
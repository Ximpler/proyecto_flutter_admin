import '../../../domain/entities/normal_user.dart';

abstract class IRemoteNormalUserSource {
  Future<List<NormalUser>> getNormalUsers();

  Future<NormalUser> getNormalUser(int id);

  Future<bool> addNormalUser(NormalUser normal_user);

  Future<bool> updateNormalUser(NormalUser normal_user);

  Future<bool> deleteNormalUser(int id);

  Future<bool> deleteNormalUsers();
}
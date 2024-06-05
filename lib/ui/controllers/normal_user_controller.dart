import 'package:proyecto_flutter_admin/ui/controllers/connectivity_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/normal_user.dart';
import '../../domain/use_cases/normal_user_usecase.dart';

class NormalUserController extends GetxController {
  final RxList<NormalUser> _normal_users = <NormalUser>[].obs;
  final Rx<NormalUser?> _normal_user = Rx<NormalUser?>(null);
  final NormalUserUseCase normal_userUseCase = Get.find();
  final ConnectivityController connectivity = Get.find();

  List<NormalUser> get normal_users => _normal_users;
  NormalUser? get normal_user => _normal_user.value;
  
  @override
  void onInit() {
    getNormalUsers();

    super.onInit();
  }

  Future<void> getNormalUsers() async {
    logInfo("Getting normal_users");
    _normal_users.value = await normal_userUseCase.getNormalUsers();
  }

  Future<void> getNormalUser(int id) async {
    logInfo("Getting normal_users");
    _normal_user.value = await normal_userUseCase.getNormalUser(id);
  }

  Future<void> addNormalUser(NormalUser normal_user) async {
    logInfo("Add normal_user");
    await normal_userUseCase.addNormalUser(normal_user);
    getNormalUsers();
  }

  Future<void> updateNormalUser(NormalUser normal_user) async {
    logInfo("Update normal_user");
    await normal_userUseCase.updateNormalUser(normal_user);
    getNormalUsers();
  }

  Future<void> deleteNormalUser(int id) async {
    logInfo("deleteNormalUser normal_user $id");
    await normal_userUseCase.deleteNormalUser(id);
    getNormalUsers();
  }

  Future<void> deleteNormalUsers() async {
    logInfo("deleteNormalUsers");
    await normal_userUseCase.deleteNormalUsers();
    getNormalUsers();
  }
}

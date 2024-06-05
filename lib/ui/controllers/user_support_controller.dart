import 'package:proyecto_flutter_admin/ui/controllers/connectivity_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/user_support.dart';
import '../../domain/use_cases/user_support_usecase.dart';

class UserSupportController extends GetxController {
  final RxList<UserSupport> _user_supports = <UserSupport>[].obs;
  final UserSupportUseCase user_supportUseCase = Get.find();
  final ConnectivityController connectivity = Get.find();

  List<UserSupport> get user_supports => _user_supports;

  @override
  void onInit() {
    getUserSupports();
    super.onInit();
  }

  Future<void> getUserSupports() async {
    logInfo("Getting user_supports");
    _user_supports.value = await user_supportUseCase.getUserSupports();
  }

  Future<void> addUserSupport(UserSupport user_support) async {
    logInfo("Add user_support");
    await user_supportUseCase.addUserSupport(user_support);
    getUserSupports();
  }

  Future<void> updateUserSupport(UserSupport user_support) async {
    logInfo("Update user_support");
    await user_supportUseCase.updateUserSupport(user_support);
    getUserSupports();
  }

  Future<void> deleteUserSupport(int id) async {
    logInfo("deleteUserSupport user_support $id");
    await user_supportUseCase.deleteUserSupport(id);
    getUserSupports();
  }

  Future<void> deleteUserSupports() async {
    logInfo("deleteUserSupports");
    await user_supportUseCase.deleteUserSupports();
    getUserSupports();
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'user_support_controller.dart';
import '../../domain/entities/user_support.dart';

class AuthController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  var passwordVisibility = false.obs;

  UserSupportController user_supportController = Get.find();

  @override
  void onInit() {
    super.onInit();
    user_supportController.getUserSupports();
  }

  void login() {
    if (emailController.text == 'a@a.com' &&
        passwordController.text == '1234') {
      Get.toNamed('/homepage_uc');
    } else if (emailController.text == 'b@b.com' &&
        passwordController.text == '1234') {
      Get.toNamed('/homepage_uc');
    } else {
      var userSupport =
          getUserSupport(emailController.text, passwordController.text);
      if (userSupport != null) {
        Get.toNamed('/view_report', arguments: userSupport);
      } else {
        Get.snackbar('Error', 'Invalid credentials');
      }
    }
  }

  UserSupport? getUserSupport(String email, String password) {
    for (var userSupport in user_supportController.user_supports) {
      if (userSupport.email == email && userSupport.password == password) {
        return userSupport;
      }
    }
    return null;
  }
}

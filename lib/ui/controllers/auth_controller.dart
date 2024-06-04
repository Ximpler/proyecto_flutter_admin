import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  var passwordVisibility = false.obs;

  void login() {
    if (emailController.text == 'a@a.com' && passwordController.text == '1234') {
      Get.toNamed('/homepage_uc');
    } else if (emailController.text == 'b@b.com' && passwordController.text == '1234') {
      Get.toNamed('/homepage_uc');
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }
}
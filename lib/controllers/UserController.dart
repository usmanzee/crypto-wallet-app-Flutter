import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/repository/user_repository.dart';

class UserController extends GetxController {
  var user = new User().obs;
  var isLoading = true.obs;
  UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async {
    try {
      isLoading(true);
      user.value = await _userRepository.fetchUser();
    } catch (error) {
      isLoading(false);
      var errorResponseObj = error.errorResponse();
      Get.snackbar('Error', errorResponseObj['message'],
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
    }
  }
}

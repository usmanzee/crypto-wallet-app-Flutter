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
  }

  @override
  void onClose() {
    super.onClose();
  }
}

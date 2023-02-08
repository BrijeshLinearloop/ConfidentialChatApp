import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    print("init user");

    Timer(Duration(seconds:3), () {
      navigateUser();
    });

  }

  @override
  void onReady() {
    super.onReady();
    print("Onready user");

    Timer(Duration(seconds:3), () {
      navigateUser();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  navigateUser() {
    print("Navigate user");
    Get.offAllNamed(Routes.LOGIN);
  }


}

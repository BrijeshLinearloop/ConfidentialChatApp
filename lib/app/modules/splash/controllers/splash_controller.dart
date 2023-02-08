import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();

    Timer(Duration(seconds:3), () {
      navigateUser();
    });

  }

  @override
  void onReady() {
    super.onReady();

    Timer(Duration(seconds:3), () {
      navigateUser();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  navigateUser() {
    Get.offAllNamed(Routes.LOGIN);
  }


}

import 'dart:async';

import 'package:confidential_chat_app/utils/preferences_manage.dart';
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

  navigateUser() async {

    var isLoginUser = await PreferencesManage.getPreferencesValue(PreferencesManage.isUserLogin);
    print("isLoginUser => ${isLoginUser.toString()}");

    if(isLoginUser != null && isLoginUser.toString() == "1"){
      Get.offAllNamed(Routes.DASHBOARD);
    }else{
      Get.offAllNamed(Routes.LOGIN);
    }

  }


}

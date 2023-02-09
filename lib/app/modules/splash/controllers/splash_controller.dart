import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confidential_chat_app/utils/preferences_manage.dart';
import 'package:get/get.dart';

import '../../../../utils/constants_class.dart';
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

    if (await ConstantsClass.isNetworkConnected()) {

      var isLoginUser = await PreferencesManage.getPreferencesValue(PreferencesManage.isUserLogin);
      print("isLoginUser => ${isLoginUser.toString()}");

      if(isLoginUser != null && isLoginUser.toString() == "1"){
        Get.offAllNamed(Routes.DASHBOARD);
      }else{
        Get.offAllNamed(Routes.LOGIN);
      }

    }else{

      // dialog..

    }
  }


}

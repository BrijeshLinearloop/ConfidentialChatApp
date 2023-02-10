import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/preferences_manage.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {

  var loginUserProfile = "".obs;
  var loginUserEmail = "".obs;
  var loginUserPhoneNumber = "".obs;
  var loginUserName = "".obs;


  @override
  void onInit() {

    getUserDetails();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUserDetails() async {

    loginUserProfile.value = await PreferencesManage.getPreferencesValue(PreferencesManage.loginUserProfileImage);
    loginUserEmail.value = await PreferencesManage.getPreferencesValue(PreferencesManage.loginUserEmail);
    loginUserPhoneNumber.value = await PreferencesManage.getPreferencesValue(PreferencesManage.loginUserPhoneNumber);
    loginUserName.value = await PreferencesManage.getPreferencesValue(PreferencesManage.loginUserName);

  }

  logoutUser(){

    // clear all login data...
    PreferencesManage.setPreferencesValue(PreferencesManage.isUserLogin, "");
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserDocumentId, "");
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserEmail, "");
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserName, "");
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserGoogleLoginToken, "");
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserProfileImage, "");
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserPhoneNumber, "");

    // go to login screen...
    Get.offAllNamed(Routes.LOGIN);

  }

}

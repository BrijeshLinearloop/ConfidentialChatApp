import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants_class.dart';
import '../../../../utils/firebase_database.dart';
import '../../../../utils/preferences_manage.dart';

class RegistrationController extends GetxController {

  CollectionReference users = FirebaseFirestore.instance.collection(FirebaseDatabase.tblUser);

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var userGoogleLoginId = "".obs;
  var userGooglePhotoUrl = "".obs;

  var isEmailReadOnly = false.obs;
  var showPassword = true.obs;
  var showConfirmPassword = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var isApiCall = false.obs;

  void signUp() async {

    if(passwordController.text.toString() != confirmPasswordController.text.toString()){
      ConstantsClass.toastMessage("Password and confirm password doesn't match");
    }else{
      if (await ConstantsClass.isNetworkConnected()) {
        // check sign up details...

        isApiCall.value = true;

        addUser(emailIdController.text,userGoogleLoginId.value,passwordController.text,userGooglePhotoUrl.value,
        usernameController.text,phoneNoController.text);

      } else {
        ConstantsClass.toastMessage("No internet connection try again later...");
      }
    }

  }

  Future<void> addUser(var email,var googleLoginToken, var password,var googleLoginPhotoURL,var username, var phoneNo) async {

    var fcmToken = await PreferencesManage.getPreferencesValue(PreferencesManage.fcmToken);
    String currentDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    // Call the user's CollectionReference to add a new user
    return users.add({
      FirebaseDatabase.userEmail: "$email",
      FirebaseDatabase.userFcmToken: fcmToken,
      FirebaseDatabase.userGoogleLoginToken: "$googleLoginToken",
      FirebaseDatabase.userPassword: "$password",
      FirebaseDatabase.userUpdateDate: "$currentDate",
      FirebaseDatabase.userProfileImage: "$googleLoginPhotoURL",
      FirebaseDatabase.userUsername: "$username",
      FirebaseDatabase.userPhoneNumber: "$phoneNo",
      FirebaseDatabase.userCreatedDate: "$currentDate",
    }).then((value) {
      // user added successfully.
      isApiCall.value = false;
      ConstantsClass.toastMessage("Signup Successfully.");
      Get.back();
    },).catchError((error) => failToAddUser(error));
  }

  failToAddUser(var error){
    isApiCall.value = false;
    if(error != null && error != ""){
      print("Failed to add user: $error");
      ConstantsClass.toastMessage(error);
    }else{
      ConstantsClass.toastMessage("Fail to signup user.");
    }

  }

  getGoogleLoginDetails(){
    var argumentData = Get.arguments;
    if(argumentData != null){
      usernameController.text = argumentData['user_display_name'];
      phoneNoController.text = argumentData['user_phone'];
      emailIdController.text = argumentData['user_email'];
      userGoogleLoginId.value =  argumentData['user_id'];
      userGooglePhotoUrl.value =  argumentData['user_photo_url'];

      if(argumentData['user_email'] != null && argumentData['user_email'] != ""){
        isEmailReadOnly.value = true;
      }

    }
  }

  @override
  void onInit() {

    ConstantsClass.fcmTokenRefresh();

    getGoogleLoginDetails();

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

}

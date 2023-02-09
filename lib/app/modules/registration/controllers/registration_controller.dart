import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../utils/constants_class.dart';

class RegistrationController extends GetxController {

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
        ConstantsClass.toastMessage("Coming soon");
      } else {
        ConstantsClass.toastMessage("No internet connection try again later...");
      }
    }

  }

  googleLoginOnPress() async {

    if (await ConstantsClass.isNetworkConnected()) {

      isApiCall.value = true;

      // sign out current user...
      _googleSignIn.signOut();

      // sign in user...
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await _auth.signInWithCredential(credential);
      var userDetails = authResult.user;

      if(userDetails != null){

        var userEmail = userDetails.email;
        var userDisplayName = userDetails.displayName;
        var userPhotoUrl = userDetails.photoURL;
        var userID = userDetails.uid;
        var userPhone = userDetails.phoneNumber ?? "";

        print("googleLogin userEmail => $userEmail");
        print("googleLogin userDisplayName => $userDisplayName");
        print("googleLogin userPhotoUrl => $userPhotoUrl");
        print("googleLogin userID => $userID");
        print("googleLogin userPhone => $userPhone");

        isApiCall.value = false;

        ConstantsClass.toastMessage("Login successfully.");

      }else{
        isApiCall.value = false;
        ConstantsClass.toastMessage("Please try again.");
      }

    } else {
      ConstantsClass.toastMessage("No internet connection try again later...");
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

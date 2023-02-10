
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidential_chat_app/utils/constants_class.dart';

import 'package:confidential_chat_app/utils/firebase_database.dart';
import 'package:confidential_chat_app/utils/preferences_manage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {

  CollectionReference users = FirebaseFirestore.instance.collection(FirebaseDatabase.tblUser);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var showPassword = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var isApiCall = false.obs;

  void userSignIn() async {
    if (await ConstantsClass.isNetworkConnected()) {
      // check sign in details...

      isApiCall.value = true;
      isAuthUserExist(emailIdController.text.trim(), passwordController.text.trim());

    } else {
      ConstantsClass.toastMessage("No internet connection try again later...");
    }
  }

  googleLoginOnPress() async {

    if (await ConstantsClass.isNetworkConnected()) {

      isApiCall.value = true;

      // sign out current user...
      _googleSignIn.signOut();

      // sign in user...
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn().catchError((error) => failError(error));

      if(googleSignInAccount == null){
        isApiCall.value = false;
      }else{

        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        var authResult = await _auth.signInWithCredential(credential).catchError((error) => failError(error));
        var userDetails = authResult.user;

        if(userDetails != null){

          var userEmail = userDetails.email ?? "";
          var userDisplayName = userDetails.displayName ?? "";
          var userPhotoUrl = userDetails.photoURL ?? "";
          var userID = userDetails.uid ?? "";
          var userPhone = userDetails.phoneNumber ?? "";

          print("googleLogin userEmail => $userEmail");
          print("googleLogin userDisplayName => $userDisplayName");
          print("googleLogin userPhotoUrl => $userPhotoUrl");
          print("googleLogin userID => $userID");
          print("googleLogin userPhone => $userPhone");

          isGoogleUserExist(userEmail,userDisplayName,userPhotoUrl,userID,userPhone);

        }else{
          isApiCall.value = false;
          ConstantsClass.toastMessage("Please try again.");
        }

      }

    } else {
      ConstantsClass.toastMessage("No internet connection try again later...");
    }

    isApiCall.value = false;

  }

  Future<void> isAuthUserExist(var email, var password) async {
    try {
      await users.where(FirebaseDatabase.userEmail, isEqualTo: email)
          .where(FirebaseDatabase.userPassword, isEqualTo: password)
          .get()
          .then((value) {
            //value.size > 0 ? true : false

            if(value.size > 0){
              // user Exist...

              var userDocsId = value.docs.first.id;
              var userEmail = value.docs.first[FirebaseDatabase.userEmail];
              var username = value.docs.first[FirebaseDatabase.userUsername];
              var userGoogleLoginToken = value.docs.first[FirebaseDatabase.userGoogleLoginToken];
              var userProfileImage = value.docs.first[FirebaseDatabase.userProfileImage];
              var userPhoneNumber = value.docs.first[FirebaseDatabase.userPhoneNumber];

              print("loginDetails username => $username");
              print("loginDetails userEmail => $userEmail");
              print("loginDetails userGoogleLoginToken => $userGoogleLoginToken");
              print("loginDetails userProfileImage => $userProfileImage");
              print("loginDetails userPhoneNumber => $userPhoneNumber");
              print("loginDetails userDocsId => $userDocsId");

              ConstantsClass.toastMessage("User login successfully");

              goToDashboardScreen(userDocsId,userEmail, username, userGoogleLoginToken, userProfileImage, userPhoneNumber);

            }else{
              // user Not Exist...
              isApiCall.value = false;
              ConstantsClass.toastMessage("User not exist.");
            }

          },);
    } catch (e) {
      debugPrint(e.toString());
      isApiCall.value = false;
      ConstantsClass.toastMessage("User not exist.");
    }

  }

  Future<void> isGoogleUserExist(var userEmail, var userDisplayName, var userPhotoUrl, var userID, var userPhone) async {
    try {
      await users.where(FirebaseDatabase.userEmail, isEqualTo: userEmail)
          .get()
          .then((value) {

            //value.size > 0 ? true : false

            if(value.size > 0){
              // user Exist...

              var userDocsId = value.docs.first.id;
              var userEmail = value.docs.first[FirebaseDatabase.userEmail];
              var username = value.docs.first[FirebaseDatabase.userUsername];
              var userGoogleLoginToken = value.docs.first[FirebaseDatabase.userGoogleLoginToken];
              var userProfileImage = value.docs.first[FirebaseDatabase.userProfileImage];
              var userPhoneNumber = value.docs.first[FirebaseDatabase.userPhoneNumber];

              print("loginDetails username => $username");
              print("loginDetails userEmail => $userEmail");
              print("loginDetails userGoogleLoginToken => $userGoogleLoginToken");
              print("loginDetails userProfileImage => $userProfileImage");
              print("loginDetails userPhoneNumber => $userPhoneNumber");
              print("loginDetails userDocsId => $userDocsId");

              ConstantsClass.toastMessage("User login successfully");

              goToDashboardScreen(userDocsId,userEmail, username, userGoogleLoginToken, userProfileImage, userPhoneNumber);

            }else{
              // user Not Exist...
              isApiCall.value = false;
              goToSignUpScreen(userEmail, userDisplayName, userPhotoUrl, userID, userPhone);

            }

          },
      );
    } catch (e) {
      debugPrint(e.toString());
      isApiCall.value = false;
      goToSignUpScreen(userEmail, userDisplayName, userPhotoUrl, userID, userPhone);
    }

  }

  Future<void> goToDashboardScreen(var userDocsId, var userEmail, var username, var userGoogleLoginToken,
      var userProfileImage, var userPhoneNumber)async {

    // store login details in Preferences.
    PreferencesManage.setPreferencesValue(PreferencesManage.isUserLogin, "1");
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserDocumentId, userDocsId);
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserEmail, userEmail);
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserName, username);
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserGoogleLoginToken, userGoogleLoginToken);
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserProfileImage, userProfileImage);
    PreferencesManage.setPreferencesValue(PreferencesManage.loginUserPhoneNumber, userPhoneNumber);

    isApiCall.value = false;

    // go to dashboard screen.
    Get.offAllNamed(Routes.DASHBOARD);

  }

  Future<void> goToSignUpScreen(var userEmail, var userDisplayName, var userPhotoUrl,
      var userID, var userPhone)async {

    Get.toNamed(Routes.REGISTRATION,arguments:{
      "user_email":"$userEmail",
      "user_display_name":"$userDisplayName",
      "user_photo_url":"$userPhotoUrl",
      "user_id":"$userID",
      "user_phone":"$userPhone",
    } );


  }


  @override
  void onInit() {

    ConstantsClass.fcmTokenRefresh();

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

  failError(error) {
    isApiCall.value = false;
  }

}

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

  CollectionReference users = FirebaseFirestore.instance.collection(FirebaseDatabase.tbluser);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var showPassword = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var isApiCall = false.obs;

  void userSignIn() async {
    if (await ConstantsClass.isNetworkConnected()) {
      // check sign in details...
      ConstantsClass.toastMessage("Coming soon");
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

        Get.toNamed(Routes.REGISTRATION,arguments:{
          "user_email":"$userEmail",
          "user_display_name":"$userDisplayName",
          "user_photo_url":"$userPhotoUrl",
          "user_id":"$userID",
          "user_phone":"$userPhone",
        } );

        //ConstantsClass.toastMessage("Login successfully.");

      }else{
        isApiCall.value = false;
        ConstantsClass.toastMessage("Please try again.");
      }

    } else {
      ConstantsClass.toastMessage("No internet connection try again later...");
    }



  }

  Future<void> emailLogin()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "beeerry.allen@example.com",
          password: "SuperSecretPassword!"
      );
      print("add user");
      addUser();
      print("user added");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUser() async {
    print("Sucess");

    var fcmToken = await PreferencesManage.getPreferencesValue(PreferencesManage.fcmToken);

    // Call the user's CollectionReference to add a new user
    return users.add({
      FirebaseDatabase.userId: "john",
      FirebaseDatabase.userEmail: "Useremail",
      FirebaseDatabase.userFcmToken: fcmToken,
      FirebaseDatabase.userGoogleLoginToken: "token",
      FirebaseDatabase.userPassword: "pass",
      FirebaseDatabase.userUpdateDate: "update",
      FirebaseDatabase.userProfileImage: "profile",
      FirebaseDatabase.userUsername: "username",
      FirebaseDatabase.userPhoneNumber: "phone",
      FirebaseDatabase.userCreatedDate: "create",

    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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

}

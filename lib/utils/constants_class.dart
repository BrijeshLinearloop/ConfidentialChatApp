import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:confidential_chat_app/utils/math_utils.dart';
import 'package:confidential_chat_app/utils/preferences_manage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class ConstantsClass{

  static var fontFamily = GoogleFonts.roboto().fontFamily;

  static toastMessage(var message){
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstant.colorBlackTransparent,
        textColor: ColorConstant.colorWhite,
        fontSize: 16.0
    );
  }

  static Widget apiLoadingWidget(){
    return Container(
      height: Get.height,
      width: Get.width,
      color: ColorConstant.colorBlackTransparent,
      child: Center(
        child: Container(
          height: 100,
          width: 250,
          decoration: BoxDecoration(
            color: ColorConstant.colorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.colorGrey,
                spreadRadius: getHorizontalSize(2.00),
                blurRadius: getHorizontalSize(2.00,),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitCircle(size: 50,color: ColorConstant.colorPrimary,),
              Text(
                "Loading...",
                style: TextStyle(
                  color: ColorConstant.colorPrimary,
                  fontSize: getFontSize(16),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  static Future<bool> isNetworkConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;// connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;// connected to a wifi network.
    }else{
      return false;
    }
  }

  // get Firebase notification token.
  static void fcmTokenRefresh(){

    FirebaseMessaging.instance.getToken().then((value) {

      print("fcmToken => ${value.toString()}");

      PreferencesManage.setPreferencesValue(PreferencesManage.fcmToken,value.toString());

    },);

  }

}
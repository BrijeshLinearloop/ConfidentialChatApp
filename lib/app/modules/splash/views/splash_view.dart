import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetWidget<SplashController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.colorWhite,
        body: SafeArea(
          child: Container(

              decoration: BoxDecoration(color: ColorConstant.colorWhite),
              child:
              Align(
                  alignment: Alignment.center,
                    child: Image.asset("",height: 30,width: 100,),

          ),
        )));
  }
}

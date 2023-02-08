import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:confidential_chat_app/utils/constants_class.dart';
import 'package:confidential_chat_app/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../../utils/math_utils.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetWidget<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorWhite,
      body: SafeArea(
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                googleLoginButton()

              ],
            ),

            controller.isApiCall.value ? ConstantsClass.apiLoadingWidget() : SizedBox()

          ],
        ),
      ),
    );
  }

  Widget googleLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BouncingWidget(
            onPressed: () {
              // controller.googleLoginOnPress();
              // controller.addUser();
              controller.emailLogin();
              print("google login pressed");
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
              alignment: Alignment.center,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset(ImagePaths.iconGoogle),
                  ),

                  const SizedBox(width: 20,),

                  Text("Sign In with Google", style: TextStyle(
                    color: ColorConstant.colorBalck,
                    fontSize: getFontSize(14),
                    fontWeight: FontWeight.w500,
                  ),)


                ],
              ),
            )
        )
      ],
    );
  }

}

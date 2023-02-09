import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:confidential_chat_app/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants_class.dart';
import '../../../../utils/math_utils.dart';
import '../../../../utils/validation_functions.dart';
import '../../../../widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetWidget<LoginController> {
  LoginView({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorWhite,
      body: SafeArea(
        child: Stack(
          children: [

            SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      const SizedBox(height: 50,),

                      SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child:SvgPicture.asset(ImagePaths.linearlooplogo),
                      ),


                      Text(
                        "Sign in",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.colorPrimary,
                          fontSize: getFontSize(22),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 50,),

                      Padding(
                          padding: EdgeInsets.only(left: getHorizontalSize(32.00), right: getHorizontalSize(32.00)),
                          child: CustomTextField(
                            isReadOnly:false,
                            keyboardType: TextInputType.emailAddress,
                            textInputFiler: [FilteringTextInputFormatter.deny(RegExp('[ ]')),],
                            textInputAction: TextInputAction.next,
                            label: "Email",
                            controller: controller.emailIdController,
                            obscureText: false,
                            hint: "Enter email",
                            validator: (value) {
                              if (value == null || (!isValidEmail(value, isRequired: true))) {
                                return "Please enter valid email address";
                              }
                              return null;
                            },
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.only(left: getHorizontalSize(32.00), top: getVerticalSize(18.00), right: getHorizontalSize(32.00)),

                          child: Obx(() =>
                              CustomTextField(
                                  isReadOnly:false,
                                  textInputAction: TextInputAction.done,
                                  label: "Password",
                                  controller: controller.passwordController,
                                  hint: "Enter Password",
                                  validator: (value) {
                                    if (value == null || (!isValidPassword(value, isRequired: true))) {
                                      return "Please enter valid password";
                                    }
                                    return null;
                                  },
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(10.00),
                                      right: getHorizontalSize(10.00)
                                    ),
                                    child: Container(
                                        height: getSize(25),
                                        width: getSize(25),
                                        child: InkWell(
                                          child: Icon(
                                            controller.showPassword.value ? Icons.visibility_off : Icons.visibility,
                                            color: Colors.grey,
                                            size: getSize(20),
                                          ),
                                          onTap: () {
                                            controller.showPassword.value = !controller.showPassword.value;
                                          },
                                        )
                                    ),
                                  ),
                                  obscureText: controller.showPassword.value
                              )
                          )
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        padding: EdgeInsets.only(left: getHorizontalSize(32.00),right: getHorizontalSize(32.00)),
                        child: signInButton(),
                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: Get.width-getHorizontalSize(64),
                        child: Row(
                          children: [

                            Expanded(
                              child: Container(
                                height: 1,
                                color: ColorConstant.colorGrey,
                              ),
                            ),

                            Container(
                                margin: EdgeInsets.only(right: 10,left: 10),
                                child: Text("OR",
                                  style:TextStyle(
                                    color: ColorConstant.colorBalck,
                                    fontSize: getFontSize(18),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),

                            Expanded(
                              child: Container(
                                height: 1,
                                color: ColorConstant.colorGrey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      googleLoginButton(),

                    ],
                  ),
                ),
              ),
            ),

            Obx(() {
              return controller.isApiCall.value ? ConstantsClass.apiLoadingWidget() : SizedBox();
            })

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
              controller.googleLoginOnPress();
              print("google login pressed");
            },
            child: Container(
              width: Get.width-getHorizontalSize(64),
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorConstant.colorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.colorGrey,
                    spreadRadius: getHorizontalSize(0.50),
                    blurRadius: getHorizontalSize(0.50),
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

                  Text(
                    "Sign In with Google",
                    style: TextStyle(
                      color: ColorConstant.colorBalck,
                      fontSize: getFontSize(16),
                      fontWeight: FontWeight.w500,
                    ),
                  )


                ],
              ),
            )
        )
      ],
    );
  }

  Widget signInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BouncingWidget(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.userSignIn();
              }
            },
            child: Container(
              width: Get.width-getHorizontalSize(64),
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorConstant.colorPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.colorGrey,
                    spreadRadius: getHorizontalSize(0.50),
                    blurRadius: getHorizontalSize(0.50),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: ColorConstant.colorWhite,
                      fontSize: getFontSize(18),
                      fontWeight: FontWeight.bold,
                    ),
                  )


                ],
              ),
            )
        )
      ],
    );
  }

}

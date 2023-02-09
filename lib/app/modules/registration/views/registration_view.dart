import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/constants_class.dart';
import '../../../../utils/image_paths.dart';
import '../../../../utils/math_utils.dart';
import '../../../../utils/validation_functions.dart';
import '../../../../widgets/custom_text_field.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends GetWidget<RegistrationController> {
  RegistrationView({Key? key}) : super(key: key);

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
                        "Sign Up",
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
                            keyboardType: TextInputType.text,
                            textInputFiler: [FilteringTextInputFormatter.deny(RegExp('[ ]')),],
                            textInputAction: TextInputAction.next,
                            label: "Username",
                            controller: controller.usernameController,
                            obscureText: false,
                            hint: "Enter username",
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter username";
                              }
                              return null;
                            },
                          )
                      ),

                      Padding(
                          padding: EdgeInsets.only(left: getHorizontalSize(32.00),top: getVerticalSize(18.00), right: getHorizontalSize(32.00)),
                          child: CustomTextField(
                            isReadOnly: controller.isEmailReadOnly.value,
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
                          child: CustomTextField(
                            isReadOnly:false,
                            keyboardType: TextInputType.number,
                            textInputFiler: [FilteringTextInputFormatter.deny(RegExp('[ ]')),],
                            textInputAction: TextInputAction.next,
                            label: "Phone number",
                            controller: controller.phoneNoController,
                            obscureText: false,
                            hint: "Enter phone number",
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter phone number";
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
                                  textInputAction: TextInputAction.next,
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

                      Padding(
                          padding: EdgeInsets.only(left: getHorizontalSize(32.00), top: getVerticalSize(18.00), right: getHorizontalSize(32.00)),

                          child: Obx(() =>
                              CustomTextField(
                                  isReadOnly:false,
                                  textInputAction: TextInputAction.done,
                                  label: "Confirm password",
                                  controller: controller.confirmPasswordController,
                                  hint: "Enter Password",
                                  validator: (value) {
                                    if (value == null || (!isValidPassword(value, isRequired: true))) {
                                      return "Please enter valid confirm password";
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
                                            controller.showConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
                                            color: Colors.grey,
                                            size: getSize(20),
                                          ),
                                          onTap: () {
                                            controller.showConfirmPassword.value = !controller.showConfirmPassword.value;
                                          },
                                        )
                                    ),
                                  ),
                                  obscureText: controller.showConfirmPassword.value
                              )
                          )
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        padding: EdgeInsets.only(left: getHorizontalSize(32.00),right: getHorizontalSize(32.00)),
                        child: signUpButton(),
                      ),

                      SizedBox(height: 20,),

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

  Widget signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BouncingWidget(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.signUp();
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
                    "Sign Up",
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

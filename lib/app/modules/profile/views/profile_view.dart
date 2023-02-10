
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/constants_class.dart';
import '../../../../utils/math_utils.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetWidget<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  headerDesign(),


                  Container(
                    width: Get.width,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Obx(() {return itemView("Username", controller.loginUserName.value);}),
                        Obx(() {return itemView("E-Mail", controller.loginUserEmail.value);}),
                        Obx(() {return itemView("Phone No", controller.loginUserPhoneNumber.value);}),
                        logoutView(context)
                      ],
                    ),
                  )

                ],
              )

            ],
          )
      ),
    );
  }

  Widget itemView(var key, var value) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: ColorConstant.colorPrimary),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(key,
            style: TextStyle(
                color: ColorConstant.colorBalck,
                fontSize: getFontSize(16),
                fontWeight: FontWeight.bold,
                fontFamily: ConstantsClass.fontFamily
            ),
          ),

          SizedBox(height: 5,),

          Text(value,
            style: TextStyle(
                color: ColorConstant.colorGrey,
                fontSize: getFontSize(16),
                fontWeight: FontWeight.normal,
                fontFamily: ConstantsClass.fontFamily
            ),
          ),


        ],
      ),
    );
  }

  Widget logoutView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        onTap: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.scale,
            title: 'Logout',
            desc: 'Are you sure you want to logout?',
            btnCancelColor: ColorConstant.colorGrey,
            btnOkColor: ColorConstant.colorRed,
            btnCancelText: "No",
            btnOkText: "Logout",
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              controller.logoutUser();
            },
          ).show();

        },
        child: Container(
          width: Get.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorConstant.colorPrimary),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("Logout",
                style: TextStyle(
                    color: ColorConstant.colorBalck,
                    fontSize: getFontSize(16),
                    fontWeight: FontWeight.bold,
                    fontFamily: ConstantsClass.fontFamily
                ),
              ),

              Icon(
                Icons.logout_rounded,
                color: ColorConstant.colorBalck,
                size: 30,
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget headerDesign() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        color: ColorConstant.colorSkyBlue,
      ),
      child: Column(
        children: [

          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.arrow_back_rounded,color: ColorConstant.colorWhite,size: 30,)),
                ),

                Container(
                  child: Text(
                    "Profile",
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontFamily: ConstantsClass.fontFamily,
                      color: ColorConstant.colorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: getFontSize(18),
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(width: 40,),
              ],
            ),
          ),

          Obx(() {
            return Hero(
              tag: 'profile',
              child: Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: ColorConstant.colorWhite),
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${controller.loginUserProfile.value}"),
                  radius: 18,
                ),
              ),
            );
          }),


        ],
      ),
    );
  }
}

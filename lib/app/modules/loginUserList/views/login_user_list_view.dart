import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:confidential_chat_app/utils/constants_class.dart';
import 'package:confidential_chat_app/utils/math_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_user_list_controller.dart';

class LoginUserListView extends GetView<LoginUserListController> {
  const LoginUserListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("User list",style: TextStyle(
            letterSpacing: 1.0  ) ,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorConstant.colorSkyBlue,
      ),

      body: SafeArea(
        child: Stack(
          children: [

            SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    //height: 45,
                    child: TextField(
                      decoration:InputDecoration(
                        contentPadding: EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                        hintText: "Search...",
                        border: OutlineInputBorder()
                      ),
                      onChanged: (value) {
                        if(value != null){
                          controller.searchUser(value.toString().trim());
                        }
                      },
                    ),
                  ),
                ),

                Obx(() {
                  return controller.listAllUsers.length > 0
                      ?
                  ListView.builder(
                      shrinkWrap:  true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.listAllUsers.length,
                      itemBuilder: (BuildContext context, int index){
                        return  Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.lightBlue,
                                  backgroundImage: NetworkImage(controller.listAllUsers[index].userProfileImage),
                                ),

                              ],
                            ),

                            SizedBox(width: 15,),
                            Text(controller.listAllUsers[index].username.toString().toTitleCase(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ColorConstant.colorBalck,
                                fontSize: getFontSize(18),
                                fontFamily: ConstantsClass.fontFamily,
                              ),
                            )
                          ],),
                        );
                      }):SizedBox();
                })

              ],),
            ),

            Obx(() {
              return controller.listAllUsers.isEmpty && !controller.isApiCall.value
                  ?
              Center(
                  child: Text("User not found.",
                    style: TextStyle(
                      fontFamily: ConstantsClass.fontFamily,
                      color: ColorConstant.colorGrey,
                      fontSize: getFontSize(16),
                      fontWeight: FontWeight.normal,
                    ),
                  )
              )
                  :
              SizedBox();

            }),

            Obx(() {
              return controller.isApiCall.value ? ConstantsClass
                  .apiLoadingWidget() : SizedBox();
            }),

          ],
        ),
      )
    );
  }
}
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ').split(' ')
          .map((str) => str.toCapitalized())
          .join(' ');
}
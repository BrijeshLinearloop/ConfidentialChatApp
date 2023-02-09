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
        actions:  [
          // InkWell(
          //     onTap: (){
          //
          //     },
          //     child: Icon(Icons.search)),
          // SizedBox(width: 10,)
        ],
      ),
     
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [

     // Obx(()=>

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 45,
                child: TextField(
                  decoration:InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder()
                  ),
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap:  true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:  10,
                itemBuilder: (BuildContext context, int index){
              return  Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(children: [
                  Stack(
                   children: [
                     CircleAvatar(
                       radius: 18,
                       backgroundColor: Colors.lightBlue,

                     ),

                     // Positioned(
                     //   bottom: 0,
                     //   right: 5,
                     //   child: CircleAvatar(
                     //     radius: 5,
                     //     backgroundColor: Colors.white,
                     //     child: CircleAvatar(radius: 4,
                     //     backgroundColor: Colors.green,
                     //     ),
                     //   ),
                     // )
                   ],
                  ),

                  SizedBox(width: 15,),
                  Text("Peter England",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.colorBalck,
                      fontSize: getFontSize(22),
                      fontFamily: ConstantsClass.fontFamily,
                    ),
                  )
                ],),
              );
            })

          ],),
        ),
      )
    );
  }
}

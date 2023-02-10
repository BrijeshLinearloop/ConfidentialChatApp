import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:confidential_chat_app/utils/constants_class.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/math_utils.dart';
import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
   ChatRoomView({Key? key}) : super(key: key);

  List messages  =[
    'receiver', 'sender','receiver','sender','receiver','sender','receiver',
    'receiver', 'sender','receiver','sender','receiver','sender','receiver',
    'sender','receiver','sender','receiver','sender','receiver', 'sender','receiver','sender','receiver','sender'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width *0.90,
              decoration: BoxDecoration(
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    )
                  ),
                ),
              ),
            ),
          ),
          Icon(Icons.send_rounded)
        ],
      ),

      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
             Container(
               decoration: BoxDecoration(
                   color: ColorConstant.colorSkyBlue,
                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
               ),
               child: Padding(
                 padding: const EdgeInsets.only(left: 8.0,right: 8.0, bottom: 15.0,top: 10),
                 child: Row(
                   children: [
                     Icon(Icons.arrow_back_ios_new_outlined,color: ColorConstant.colorWhite,size: 18,),
                     Container(
                       height: 30,
                       width: 30,
                       color: ColorConstant.colorSkyBlue,
                     ),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("John Peter",
                           style: TextStyle(
                             letterSpacing: 1.2,
                             fontFamily: ConstantsClass.fontFamily,
                             color: ColorConstant.colorWhite,
                             fontWeight: FontWeight.bold,
                             fontSize: getFontSize(22),
                             // fontWeight: FontWeight.bold,
                           ),
                         ),
                         Text("online",
                           style: TextStyle(
                             letterSpacing: 1.2,
                             fontFamily: ConstantsClass.fontFamily,
                             color: ColorConstant.colorWhite,
                             fontSize: getFontSize(18),
                             // fontWeight: FontWeight.bold,
                           ),
                         )
                       ],
                     ),
                     Spacer(),
                     Icon(Icons.more_vert,color: ColorConstant.colorWhite,size: 16,)
                   ],
                 ),
               ),
             ),


              ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                    child: Align(
                      alignment: (messages[index] == "receiver"?Alignment.topLeft:Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index]  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text("Hello", style: TextStyle(fontSize: 15),),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


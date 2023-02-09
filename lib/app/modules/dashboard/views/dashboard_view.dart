import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:confidential_chat_app/utils/constants_class.dart';
import 'package:confidential_chat_app/utils/math_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetWidget<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [

              HomePageHeader(controller),

              SizedBox(height: 20,),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text("Recent",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.colorBalck,
                        fontSize: getFontSize(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: "John",
                    messageText: "Good morning",
                    imageUrl: "",
                    time: "today",
                    isMessageRead: true,
                  );
                },
              ),
            ],
          ),

          Obx(() {
            return controller.isApiCall.value ? ConstantsClass
                .apiLoadingWidget() : SizedBox();
          })

        ],
      ),
    );
  }
}


Widget HomePageHeader(DashboardController controller) {
  return Container(
    //height: 220,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      color: ColorConstant.colorSkyBlue,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppBar(
          leading: Icon(Icons.line_weight),
          centerTitle: true,
          title: Text(
            "MESSAGES",
            overflow: TextOverflow.fade,
            textAlign: TextAlign.left,
            style: TextStyle(
              letterSpacing: 1.5,
              fontFamily: ConstantsClass.fontFamily,
              color: ColorConstant.colorWhite,
              fontSize: getFontSize(16),
              // fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Obx(() {
              return Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${controller.loginUserProfile.value}"),
                  radius: 18,
                ),
              );
            }),
            SizedBox(width: 10,)
          ],
        ),
        SizedBox(height: 10,),

        Obx(() {
          return controller.listAllUsers != null &&
              controller.listAllUsers.length > 5
              ?
          Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("view more",
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: ColorConstant.colorWhite,
                    fontSize: getFontSize(14),
                    // fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
              :
          SizedBox();
        }),

        Obx(() {
          return controller.listAllUsers != null &&
              controller.listAllUsers.length > 0
              ?
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0, right: 10, left: 10,),
            child: Container(
              height: 90,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.listAllUsers.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Row(

                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: ColorConstant.colorWhite),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(30.0)),
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  controller.listAllUsers[index]
                                      .userProfileImage),
                              radius: 10,
                            ),
                          ),
                          Text(
                            controller.listAllUsers[index].username.toString()
                                .replaceAll(" ", "\n")
                                .toTitleCase(),
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant.colorWhite,
                              fontSize: getFontSize(14),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 15,)
                    ],
                  );
                },

              ),
            ),
          )
              :
          const SizedBox();
        })


      ],
    ),
  );
}
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ').split(' ')
          .map((str) => str.toCapitalized())
          .join(' ');
}

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;

  ConversationList(
      {required this.name, required this.messageText, required this.imageUrl, required this.time, required this.isMessageRead});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: ColorConstant.colorSkyBlue
                    ),
                    // "https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText, style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.time,
              style: TextStyle(fontSize: 12, color: ColorConstant.colorGrey),),
          ],
        ),
      ),
    );
  }
}

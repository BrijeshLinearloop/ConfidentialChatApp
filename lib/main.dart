import 'package:confidential_chat_app/utils/color_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: ColorConstant.colorPrimary, // status bar color
  ));

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Confidential chat app",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

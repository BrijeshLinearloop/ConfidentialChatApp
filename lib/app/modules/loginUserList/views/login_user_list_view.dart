import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_user_list_controller.dart';

class LoginUserListView extends GetView<LoginUserListController> {
  const LoginUserListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginUserListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LoginUserListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

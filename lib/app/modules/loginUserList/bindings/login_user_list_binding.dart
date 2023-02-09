import 'package:get/get.dart';

import '../controllers/login_user_list_controller.dart';

class LoginUserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginUserListController>(
      () => LoginUserListController(),
    );
  }
}

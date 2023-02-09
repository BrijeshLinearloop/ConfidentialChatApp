import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confidential_chat_app/app/modules/loginUserList/models/beanUserList.dart';
import 'package:get/get.dart';

import '../../../../utils/constants_class.dart';
import '../../../../utils/firebase_database.dart';

class DashboardController extends GetxController {

  var isApiCall = false.obs;
  RxList<dynamic> listAllUsers = [].obs;

  @override
  void onInit() {
    getAllUserList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllUserList() async {

    isApiCall.value = true;

    if (await ConstantsClass.isNetworkConnected()) {

      CollectionReference users = FirebaseFirestore.instance.collection(FirebaseDatabase.tblUser);

      await users.get().then((allUsers) {
        print("getAllUserList => ${allUsers.size}");

        var displayUser = 5;
        if(allUsers.size < 5){
          displayUser = allUsers.size;
        }

        for (int i = 0; i < displayUser ; i++) {

          var userDocsId = allUsers.docs[i].id;
          var userEmail = allUsers.docs[i][FirebaseDatabase.userEmail];
          var username = allUsers.docs[i][FirebaseDatabase.userUsername];
          var userGoogleLoginToken = allUsers.docs[i][FirebaseDatabase.userGoogleLoginToken];
          var userProfileImage = allUsers.docs[i][FirebaseDatabase.userProfileImage];
          var userPhoneNumber = allUsers.docs[i][FirebaseDatabase.userPhoneNumber];

          listAllUsers.add(beanUserList(username: username,userEmail: userEmail, userGoogleLoginToken: userGoogleLoginToken,
              userProfileImage: userProfileImage, userPhoneNumber: userPhoneNumber, userDocsId: userDocsId));

        }

        isApiCall.value = false;

      }).catchError((error) => failToLoadData(error));


    }else{
      isApiCall.value = false;
      ConstantsClass.toastMessage("Please check your internet connection.");
    }
  }
  failToLoadData(var error){
    print("getAllUserList => $error");
    isApiCall.value = false;
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../utils/constants_class.dart';
import '../../../../utils/firebase_database.dart';
import '../../../../utils/preferences_manage.dart';
import '../models/beanUserList.dart';

class LoginUserListController extends GetxController {

  var isApiCall = false.obs;
  RxList<dynamic> listAllUsersMain = [].obs;
  RxList<dynamic> listAllUsers = [].obs;

  RxBool search =true.obs;
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

      var loginUserDocumentId = await PreferencesManage.getPreferencesValue(PreferencesManage.loginUserDocumentId);

      CollectionReference users = FirebaseFirestore.instance.collection(FirebaseDatabase.tblUser);

      await users.get().then((allUsers) {

        print("getAllUserList => ${allUsers.size}");

        for (int i = 0; i < allUsers.size ; i++) {

          var userDocsId = allUsers.docs[i].id;
          var userEmail = allUsers.docs[i][FirebaseDatabase.userEmail];
          var username = allUsers.docs[i][FirebaseDatabase.userUsername];
          var userGoogleLoginToken = allUsers.docs[i][FirebaseDatabase.userGoogleLoginToken];
          var userProfileImage = allUsers.docs[i][FirebaseDatabase.userProfileImage];
          var userPhoneNumber = allUsers.docs[i][FirebaseDatabase.userPhoneNumber];

          if(loginUserDocumentId != userDocsId){
            listAllUsersMain.add(beanUserList(username: username,userEmail: userEmail, userGoogleLoginToken: userGoogleLoginToken,
                userProfileImage: userProfileImage, userPhoneNumber: userPhoneNumber, userDocsId: userDocsId));
          }

        }

        listAllUsers.addAll(listAllUsersMain);

        isApiCall.value = false;

      }).catchError((error) => failToLoadData(error));


    }else{
      isApiCall.value = false;
      ConstantsClass.toastMessage("Please check your internet connection.");
    }
  }

  searchUser(var searchText){
    if(searchText != null && searchText != ""){
      listAllUsers.clear();
      for (int i = 0; i < listAllUsersMain.length ; i++) {
        if(listAllUsersMain[i].username.toString().toLowerCase().contains(searchText.toString().toLowerCase())){
          listAllUsers.add(listAllUsersMain[i]);
        }
      }
    }else{
      listAllUsers.clear();
      listAllUsers.addAll(listAllUsersMain);
    }
  }

  failToLoadData(var error){
    print("getAllUserList => $error");
    isApiCall.value = false;
  }


}

import 'package:confidential_chat_app/utils/constants_class.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {

  var isApiCall = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  googleLoginOnPress() async {

    isApiCall.value = true;

    // sign out current user...
    _googleSignIn.signOut();

    // sign in user...
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    var authResult = await _auth.signInWithCredential(credential);
    var userDetails = authResult.user;

    if(userDetails != null){

      var userEmail = userDetails.email;
      var userDisplayName = userDetails.displayName;
      var userPhotoUrl = userDetails.photoURL;
      var userID = userDetails.uid;
      var userPhone = userDetails.phoneNumber ?? "";

      print("googleLogin userEmail => $userEmail");
      print("googleLogin userDisplayName => $userDisplayName");
      print("googleLogin userPhotoUrl => $userPhotoUrl");
      print("googleLogin userID => $userID");
      print("googleLogin userPhone => $userPhone");

      isApiCall.value = false;

      ConstantsClass.toastMessage("Login successfully.");

    }else{
      isApiCall.value = false;
      ConstantsClass.toastMessage("Please try again.");
    }

  }

  @override
  void onInit() {
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

}

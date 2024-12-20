import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/functions/app_function_impl.dart';
import '../../../../utils/routes/route_names.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Future<void> getUserStatus() async {
    try {
      SharedPreferences introCompleted = await SharedPreferences.getInstance();
      // introCompleted.clear();
      isLoading.value = true;
      update();
      print(
          "[[IntroCompleted]] key == introCompleted,  ${introCompleted.getBool("introCompleted")}");
      if (introCompleted.getBool("introCompleted") != true) {
        // Get.offAll(AppRouteNames().onboardingScreen);
      } else {
        print("object IntroCompleted");
        if (FirebaseAuth.instance.currentUser != null) {
          var d = await AppFunctionImpl().getUserDetails();
          if (d == null) {
            Get.offAllNamed(AppRouteNames().registrationScreen);
          } else {
            Get.offAllNamed(AppRouteNames().homeScreen);
          }
        } else {
          // Get.offAllNamed(AppRouteNames().signUpScreen);
          Get.offAllNamed(AppRouteNames().chooseTypeScreen);
        }
      }
    } catch (e) {
      log("getUser $e");
      Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool?> loginAccount(
      {required String email, required String password}) async {
    try {
      isLoading.value = true;
      update();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.uid.isNotEmpty ?? false) {
        return true;
      }
    } catch (e) {
      log("loginAccountt $e");
      if (e.toString().contains("PigeonUserDetails")) {
        return true;
      } else if (e.toString().contains("]")) {
        List err = e.toString().split("]");
        Get.snackbar("Error", "${err[1]}");
      } else {
        Get.snackbar("Error", "$e");
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool?> createAccount(
      {required String email, required String password}) async {
    try {
      isLoading.value = true;
      update();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.uid.isNotEmpty ?? false) {
        return true;
      }
    } catch (e) {
      log("createAccountt $e");
      if (e.toString().contains("PigeonUserDetails")) {
        return true;
      } else if (e.toString().contains("]")) {
        List err = e.toString().split("]");
        Get.snackbar("Error", "${err[1]}");
      } else {
        Get.snackbar("Error", "$e");
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Alert", "Check you email.");
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  Future<bool?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      var cred = await FirebaseAuth.instance.signInWithCredential(credential);
      if (cred.user?.uid.isNotEmpty ?? false) {
        return true;
      }
    } catch (e) {
      log("signInWithGooglee $e");
      if (e.toString().contains("PigeonUserDetails")) {
        return true;
      } else if (e.toString().contains("]")) {
        List err = e.toString().split("]");
        Get.snackbar("Error", "${err[1]}");
      } else {
        Get.snackbar("Error", "$e");
      }
    }
  }
}

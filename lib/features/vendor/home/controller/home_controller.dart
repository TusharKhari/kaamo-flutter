import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kamo/utils/constants/app_constants.dart';

class HomeController extends GetxController {
  bool isLoading = false;

  Future<bool?> updateStatus() async {
    try {
      await FirebaseFirestore.instance
          .collection("vendors")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({"isActive": !(userModalConstant?.isActive ?? false)});
          userModalConstant = userModalConstant?.copyWith(isActive: !(userModalConstant?.isActive ?? false));
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }
  // ========
}

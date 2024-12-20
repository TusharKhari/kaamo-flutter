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
      userModalConstant = userModalConstant?.copyWith(
          isActive: !(userModalConstant?.isActive ?? false));
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }
  // ========

  Future<bool?> addLead({required int mobileNo}) async {
    try {
      isLoading = true;
      update();
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      DocumentReference leadRef = _firestore.collection('leads').doc("leads");

      //
      DocumentReference userRef = _firestore
          .collection("vendors")
          .doc(FirebaseAuth.instance.currentUser?.uid);
      userModalConstant = userModalConstant?.copyWith(
          points: (userModalConstant?.points ?? 0) + 1);
      Future.wait([
        //
        leadRef.update({
          'lead': FieldValue.arrayUnion(
            [
              {
                "leadNo": mobileNo,
                "refName":
                    "${userModalConstant?.firstName} ${userModalConstant?.lastName}",
                "refMobNo": userModalConstant?.mobileNumber,
                "uuid": FirebaseAuth.instance.currentUser?.uid,
                "address": userModalConstant?.fullAddress,
                "points": userModalConstant?.points ?? 0,
              }
            ],
          ),
        }),
        //
        userRef.update({"points": userModalConstant?.points})
      ]);
      // await ;
      // await ;
      return true;
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoading = false;
      update();
    }
  }
}

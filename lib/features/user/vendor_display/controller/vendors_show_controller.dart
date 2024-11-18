import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kamo/features/vendor/registration/modals/registration_modal.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../vendor/registration/modals/categories_modal/categories_modal.dart';

class VendorsShowController extends GetxController {
  RxBool isLoading = false.obs;
  DocumentSnapshot? startAfter;

  List<RegistrationModal> usersList = [];
  List<CategoriesModal> categoriesList = [];
  bool isAllLoaded = false;
  Future<void> fetchUsers({int limit = 100}) async {
    if (isAllLoaded == false) {
      try {
        isLoading.value = true;
        update();
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        Query query = firestore.collection('vendors').limit(limit);

        // If there's a startAfter value (i.e., pagination), apply it
        if (startAfter != null) {
          query = query.startAfterDocument(startAfter!);
        }

        QuerySnapshot querySnapshot = await query.get();

        startAfter = querySnapshot.docs.last;
        if (querySnapshot.docs.isNotEmpty) {
          List<RegistrationModal> users = querySnapshot.docs.map((doc) {
            return RegistrationModal.fromJson(
                doc.data() as Map<String, dynamic>);
          }).toList();
          usersList.addAll(users);
        } else {
          isAllLoaded = true;
        }
      } catch (e) {
        log("fetchUsers $e");
        if (e.toString().contains("Bad state: No element")) {
          isAllLoaded = true;
        } else {
          Get.snackbar("Error", "Unable to load vendors.");
        }
      } finally {
        isLoading.value = false;
        update();
      }
    }
  }

// 

Future<void> getCategories() async {
    try {
      log("getCategoriess  -->");
      isLoading.value = true;
      update();
      var d = await FirebaseFirestore.instance
          .collection("data")
          .doc("workingCategories")
          .get();
      var catData = d.data();
      
      categoriesList = (catData?["category"] as List)
          .map(
            (e) => CategoriesModal.fromJson(e),
          )
          .toList();
          log("jnfdm ${categoriesList.first.toJson()}");
     } catch (e) {
      log("message $e");
      Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  makingPhoneCall({required String phoneNo}) async {
    var url = Uri.parse("tel:$phoneNo");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

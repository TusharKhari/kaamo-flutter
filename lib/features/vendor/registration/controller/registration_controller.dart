import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kamo/features/vendor/registration/modals/categories_modal/categories_modal.dart';
import 'package:kamo/features/vendor/registration/modals/categories_modal/subcategory.dart';
import 'package:kamo/features/vendor/registration/modals/registration_modal.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/constants/app_constants.dart';

class RegistrationController extends GetxController {
  RegistrationModal registrationModal = RegistrationModal();
  RxBool isLoading = false.obs;
  bool isAddressByLocation = false;

  Future<Position?> getLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        openAppSettings();
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          openAppSettings();
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        openAppSettings();
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      log("message $e");
    }
  }

//
  List<CategoriesModal> categoriesList = [];
  List<Subcategory> subCategoriesList = [];

  void getCategories() async {
    try {
      isLoading.value = true;
      update();
      var d = await FirebaseFirestore.instance
          .collection("data")
          .doc("workingCategories")
          .get();
      var catData = d.data();
      registrationModal = registrationModal.copyWith(
          callingMobileNumber: catData?["callingMobileNo"].toString(),
          email: FirebaseAuth.instance.currentUser?.email);
      categoriesList = (catData?["category"] as List)
          .map(
            (e) => CategoriesModal.fromJson(e),
          )
          .toList();
      update();
    } catch (e) {
      log("message $e");
      Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void selectCategory({required CategoriesModal selectedCat}) {
    subCategoriesList = selectedCat.subcategories ?? [];
    registrationModal = registrationModal.copyWith(
        workingLevel1: selectedCat.name, workingLevel2: "");
    update();
  }

  void selectSubCategory({required Subcategory selectedCat}) {
    registrationModal =
        registrationModal.copyWith(workingLevel2: selectedCat.name);
    update();
  }

  Future<bool?> registerUser() async {
    try {
      isLoading.value = true;
      update();
      log("${registrationModal.toJson()}");
      checkValues();
      await FirebaseFirestore.instance
          .collection("vendors")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(registrationModal.toJson());
      userModalConstant =
          RegistrationModal.fromJson(registrationModal.toJson());
      return true;
    } catch (e) {
      log("registerUserr $e");
      Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool?> updateUser() async {
    try {
      isLoading.value = true;
      update();
      log("${registrationModal.toJson()}");
      checkValues();
      await FirebaseFirestore.instance
          .collection("vendors")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(registrationModal.toJson());
      userModalConstant =
          RegistrationModal.fromJson(registrationModal.toJson());
      return true;
    } catch (e) {
      log("registerUserr $e");
      Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void checkValues() {
    if (registrationModal.firstName?.isEmpty ?? true) {
      throw "Please fill first name.";
    }
    if (registrationModal.lastName?.isEmpty ?? true) {
      throw "Please fill last name.";
    }
    if (registrationModal.mobileNumber?.isEmpty ?? true) {
      throw "Please fill mobile number.";
    }
    if (registrationModal.streetAddress?.isEmpty ?? true) {
      throw "Please fill street address.";
    }
    if (registrationModal.pinCode?.isEmpty ?? true) {
      throw "Please fill PIN code.";
    }
    if (registrationModal.workingLevel1?.isEmpty ?? true) {
      throw "Please select working type.";
    }
  }

  Future<void> sendData() async {
    try {
      FirebaseFirestore.instance
          .collection("data")
          .doc("workingCategories")
          .set(dataJson);
    } catch (e) {
      log("sendDataa $e");
      Get.snackbar("Error", "$e");
    }
  }

  var dataJson = {
    "callingMobileNo": 8219027955,
    "category": [
      {
        "id": 1,
        "name": "Music",
        "subcategories": [
          {"id": 1, "name": "Band"},
          {"id": 2, "name": "DJ"},
          {"id": 3, "name": "Dhol"},
          {"id": 4, "name": "Live Performances"},
          {"id": 5, "name": "Singers"}
        ]
      },
      {
        "id": 2,
        "name": "Decor",
        "subcategories": [
          {"id": 1, "name": "Floral Arrangements"},
          {"id": 2, "name": "Table Centerpieces"},
          {"id": 3, "name": "Lighting"},
          {"id": 4, "name": "Drapes"}
        ]
      },
      {
        "id": 3,
        "name": "Photography",
        "subcategories": [
          {"id": 1, "name": "Candid"},
          {"id": 2, "name": "Traditional"},
          {"id": 3, "name": "Pre-Wedding Shoot"},
          {"id": 4, "name": "Drone Photography"}
        ]
      },
      {
        "id": 4,
        "name": "Food & Catering",
        "subcategories": [
          {"id": 1, "name": "Buffet"},
          {"id": 2, "name": "Cocktail Menu"},
          {"id": 3, "name": "Traditional Cuisine"},
          {"id": 4, "name": "Dessert Stations"},
          {"id": 5, "name": "Live Food Counters"}
        ]
      },
      {
        "id": 5,
        "name": "Venue",
        "subcategories": [
          {"id": 1, "name": "Indoor"},
          {"id": 2, "name": "Outdoor"},
          {"id": 3, "name": "Beach Wedding"},
          {"id": 4, "name": "Garden"}
        ]
      },
      {
        "id": 6,
        "name": "Invitations",
        "subcategories": [
          {"id": 1, "name": "Printed Invitations"},
          {"id": 2, "name": "Digital Invitations"},
          {"id": 3, "name": "Wedding Website"}
        ]
      },
      {
        "id": 7,
        "name": "Bridal Wear",
        "subcategories": [
          {"id": 1, "name": "Wedding Gowns"},
          {"id": 2, "name": "Sarees"},
          {"id": 3, "name": "Lehengas"},
          {"id": 4, "name": "Bridal Accessories"}
        ]
      },
      {
        "id": 8,
        "name": "Groom Wear",
        "subcategories": [
          {"id": 1, "name": "Suits"},
          {"id": 2, "name": "Sherwanis"},
          {"id": 3, "name": "Kurtas"},
          {"id": 4, "name": "Accessories"}
        ]
      },
      {
        "id": 9,
        "name": "Makeup & Beauty",
        "subcategories": [
          {"id": 1, "name": "Bridal Makeup"},
          {"id": 2, "name": "Hair Styling"},
          {"id": 3, "name": "Henna Designs"},
          {"id": 4, "name": "Pre-Wedding Skincare"}
        ]
      },
      {
        "id": 10,
        "name": "Wedding Favors",
        "subcategories": [
          {"id": 1, "name": "Customized Gifts"},
          {"id": 2, "name": "Edible Favors"},
          {"id": 3, "name": "Eco-Friendly Favors"},
          {"id": 4, "name": "Luxury Favors"}
        ]
      }
    ]
  };

//
}

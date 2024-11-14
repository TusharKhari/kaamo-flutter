import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:kamo/common/functions/app_function.dart';
import 'package:kamo/features/vendor/registration/modals/registration_modal.dart';
import 'package:kamo/utils/constants/app_constants.dart';

class AppFunctionImpl extends AppFunction {


    static final AppFunctionImpl _singleton = AppFunctionImpl._internal();

  factory AppFunctionImpl() {
    return _singleton;
  }

  AppFunctionImpl._internal();
  @override
  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      var d = await FirebaseFirestore.instance
          .collection("vendors")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      var dJson = d.data();
      if (dJson != null) {
        userModalConstant = RegistrationModal.fromJson(dJson);
      }
      return dJson;
    } catch (e) {
      rethrow;
     }
  }
}

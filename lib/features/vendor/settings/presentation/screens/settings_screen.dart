import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kamo/common/widgets/app_card_widget.dart';
import 'package:kamo/common/widgets/app_loading_hud.dart';

import '../../../../../utils/language/language_controller.dart';
import '../../../../../utils/routes/route_names.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isLoading = false;
  var localisationController =
      Get.put(LocalizationController(sharedPreferences: Get.find()));
  Future<void> deleteUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      var cU = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection("vendors")
          .doc(cU?.uid)
          .delete();
      await cU?.delete();
      Get.snackbar("Success", "Account deleted successfully.");
      Get.offAllNamed(AppRouteNames().loginScreen);
    } catch (e) {
      log("deleteUserr $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "settings".tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: AppLoadingHud(
        isAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              //
              30.h.verticalSpace,
              SettingCardWidget(
                title: "editInfo".tr,
                icon: Icons.edit,
                onTap: () {
                  Get.toNamed(AppRouteNames().registrationScreen,
                      arguments: {"isEdit": true});
                },
              ),
              10.h.verticalSpace,
              SettingCardWidget(
                title: "changeLanguage".tr,
                icon: Icons.delete,
                onTap: () async {
                  // await deleteUser();
                  if (localisationController.sharedPreferences
                              .getString("country_code") ==
                          "IN" &&
                      localisationController.sharedPreferences
                              .getString("language_code") ==
                          "hi") {
                    localisationController.setLanguage(Locale('en', 'US'));
                  } else {
                    localisationController.setLanguage(Locale('hi', 'IN'));
                  }
                },
              ),
              10.h.verticalSpace,
              SettingCardWidget(
                title: "logout".tr,
                icon: Icons.logout,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAllNamed(AppRouteNames().loginScreen);
                  Get.snackbar("Success", "Logout successfully.");
                },
              ),
              10.h.verticalSpace,
              SettingCardWidget(
                title: "deleteAccount".tr,
                icon: Icons.delete,
                onTap: () async {
                  await deleteUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  final void Function() onTap;
  const SettingCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AppCardWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 30,
              ),
              15.w.horizontalSpace,
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 30,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

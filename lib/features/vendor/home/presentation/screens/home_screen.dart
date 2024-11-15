import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kamo/common/widgets/app_card_widget.dart';
import 'package:kamo/utils/constants/app_constants.dart';
import 'package:kamo/utils/routes/route_names.dart';

import '../../../../../utils/language/language_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var localisationController =
      Get.put(LocalizationController(sharedPreferences: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "KAAMO EVENTS",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRouteNames().settingScreen);
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              90.h.verticalSpace,
              // Text("${userModalConstant?.toJson()}")
              AppCardWidget(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Text("${userModalConstant?.toJson()}"),
                      DetailRowWidget(
                        value1: "name".tr,
                        value2:
                            "${userModalConstant?.firstName?.capitalizeFirst} ${userModalConstant?.lastName?.capitalizeFirst}",
                      ),
                      DetailRowWidget(
                        value1: "email".tr,
                        value2: "${userModalConstant?.email}",
                      ),
                      DetailRowWidget(
                        value1: "mobileNo".tr,
                        value2: "${userModalConstant?.mobileNumber}",
                      ),
                      DetailRowWidget(
                        value1: "address".tr,
                        value2: "${userModalConstant?.fullAddress}",
                      ),
                      DetailRowWidget(
                        value1: "workAreas".tr,
                        value2:
                            "${userModalConstant?.workingLevel1}\n (${userModalConstant?.workingLevel2})",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            localisationController.setLanguage(Locale('hi', 'IN'));
          },
          icon: Icon(
            Icons.language,
            color: Colors.black,
          )),
    );
  }
}

class DetailRowWidget extends StatelessWidget {
  final String value1;
  final String value2;
  const DetailRowWidget({
    super.key,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value1,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey),
          ),
          30.w.horizontalSpace,
          Expanded(
              child: Text(
            value2,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
            textAlign: TextAlign.end,
          )),
        ],
      ),
    );
  }
}

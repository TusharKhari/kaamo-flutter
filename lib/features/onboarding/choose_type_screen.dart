import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../common/buttons/app_button.dart';
import '../../utils/routes/route_names.dart';

class ChooseTypeScreen extends StatefulWidget {
  const ChooseTypeScreen({super.key});

  @override
  State<ChooseTypeScreen> createState() => _ChooseTypeScreenState();
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //
            90.h.verticalSpace,
            LottieBuilder.asset("assets/images/choose-type.json"),
            90.h.verticalSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  title: "lookingForVendors".tr,
                  onTap: () {
                    Get.offAllNamed(AppRouteNames().vendorsShowScreen);
                  },
                  bColor: Color.fromRGBO(239, 136, 67, 1),
                ),
                30.h.verticalSpace,
                AppButton(
                  title: "registerAsVendor".tr,
                  // isReverse: true,
                  onTap: () {
                    Get.toNamed(AppRouteNames().signUpScreen);
                  },
                  // 239, 136, 67
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

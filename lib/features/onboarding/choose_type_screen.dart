import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/buttons/app_button.dart';
import '../../utils/routes/route_names.dart';

class ChooseTypeScreen extends StatefulWidget {
  const ChooseTypeScreen({super.key});

  @override
  State<ChooseTypeScreen> createState() => _ChooseTypeScreenState();
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen> {
  bool isTermsAndConditions = false;
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
                    if (isTermsAndConditions) {
                      Get.offAllNamed(AppRouteNames().vendorsShowScreen);
                    } else {
                      Get.snackbar("Error",
                          "Please agree terms and conditions & privacy policy.",
                          backgroundColor: Colors.red[200]);
                    }
                  },
                  bColor: Color.fromRGBO(239, 136, 67, 1),
                ),
                30.h.verticalSpace,
                AppButton(
                  title: "registerAsVendor".tr,
                  onTap: () {
                    if (isTermsAndConditions) {
                      Get.toNamed(AppRouteNames().signUpScreen);
                    } else {
                      Get.snackbar("Error",
                          "Please agree terms and conditions & privacy policy.",
                          backgroundColor: Colors.red[200]);
                    }
                  },

                  // 239, 136, 67
                ),
                10.h.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isTermsAndConditions,
                          onChanged: (value) {
                            setState(() {
                              isTermsAndConditions = !isTermsAndConditions;
                            });
                          },
                        ),
                        Text(
                          "iHaveReadAndAgreeToThe".tr,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(),
                        ),
                        InkWell(
                          onTap: () {
                            _launchUrl(
                                uri: "https://kaamo.in/terms-and-conditions");
                          },
                          child: Text(
                            "Terms and Conditions",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                        Text(
                          " and ",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(),
                        ),
                        InkWell(
                          onTap: () {
                            _launchUrl(uri: "https://kaamo.in/privacy-policy");
                          },
                          child: Text(
                            "Privacy Policy .",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl({required String uri}) async {
    Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

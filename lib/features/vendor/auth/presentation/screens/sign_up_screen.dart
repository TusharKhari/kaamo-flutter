// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kamo/common/buttons/app_button.dart';
import 'package:kamo/common/widgets/app_loading_hud.dart';
import 'package:kamo/common/widgets/square_tile_widget.dart';
import 'package:kamo/features/vendor/auth/controllers/auth_controller.dart';
import 'package:kamo/utils/assets/app_images.dart';
import 'package:kamo/utils/constants/app_constants.dart';
import 'package:kamo/utils/routes/route_names.dart';
import 'package:lottie/lottie.dart';
import '../../../../../common/textfields/app_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final AuthController authController;
  bool isObscureText = true;
  String email = "";
  String password = "";
  String cPassword = "";
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() async {
    authController = Get.put(
      AuthController(),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // authController.getUserStatus();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: GetBuilder(
              init: authController,
              builder: (controller) {
                return AppLoadingHud(
                  isAsyncCall: controller.isLoading.value,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/kammo_logo.svg",
                          height: 250,
                        ),
                        Text(
                          "welcomeYourJourneyBeginsHere".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                        25.h.verticalSpace,

                        // username textfield
                        AppTextField(
                          hintText: "emailTitle".tr,
                          validator: appValidatorsConstant.emailValidator,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (p0) {
                            email = p0;
                          },
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          hintText: "password".tr,
                          // validator: appValidatorsConstant.emailValidator,
                          obscureText: isObscureText,
                          onChanged: (p0) {
                            password = p0;
                          },
                          suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              child: Icon(
                                isObscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey.shade400,
                              )),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          hintText: "confirmPassword".tr,
                          // validator: appValidatorsConstant.emailValidator,
                          obscureText: isObscureText,
                          onChanged: (p0) {
                            cPassword = p0;
                          },
                          suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              child: Icon(
                                isObscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey.shade400,
                              )),
                        ),
                        SizedBox(height: 10.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Text(
                        //       "Forgot Password?",
                        //       style: TextStyle(color: Colors.grey[500]),
                        //     ),
                        //     SizedBox(
                        //       width: 25.h,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 22.h),
                        AppButton(
                          title: "signUp".tr,
                          onTap: () async {
                            // log("jnflkdm");
                            if (password.trim() == cPassword.trim()) {
                              var res = await controller.createAccount(
                                  email: email, password: password);
                              if (res == true) {
                                Get.toNamed(AppRouteNames().registrationScreen);
                              }
                            } else {
                              Get.snackbar("Alert", "Password doesn't match.");
                            }
                          },
                        ),
                        SizedBox(height: 45.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Divider(
                            thickness: 0.75,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          "orContinueWith".tr,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Divider(
                            thickness: 0.75,
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(height: 25.h),
                        InkWell(
                          onTap: () async {
                            await controller.signInWithGoogle();
                            await controller.getUserStatus();
                          },
                          child: SquareTileWidget(
                            svgPath: appIconsConstant.googleLogoSvg,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(AppRouteNames().loginScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "alreadyAMember".tr,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "loginNow".tr,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                        40.h.verticalSpace,
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

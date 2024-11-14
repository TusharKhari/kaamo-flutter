// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kamo/common/buttons/app_button.dart';
import 'package:kamo/common/widgets/app_loading_hud.dart';
import 'package:kamo/common/widgets/square_tile_widget.dart';
import 'package:kamo/utils/constants/app_constants.dart';

import '../../../../../common/textfields/app_textfield.dart';
import '../../../../../utils/routes/route_names.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthController authController;

  bool isObscureText = true;
  String email = "";
  String password = "";
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    authController = Get.put(AuthController());
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
                        //
                        Row(),
                        // logo
                        SvgPicture.asset(
                          "assets/icons/kammo_logo.svg",
                          height: 250,
                        ),
                        // welcome back, you've missed
                        Text(
                          "Welcome back you've been missed!",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                        SizedBox(height: 45.h),
                        // username textfield
                        AppTextField(
                          hintText: "Email",
                          validator: appValidatorsConstant.emailValidator,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (p0) {
                            email = p0;
                          },
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          hintText: "Password",
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
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.resetPassword(email: email);
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                            SizedBox(
                              width: 25.h,
                            ),
                          ],
                        ),
                        SizedBox(height: 22.h),
                        AppButton(
                          title: "Sign In",
                          onTap: () async {
                            var res = await controller.loginAccount(
                                email: email, password: password);
                            if (res == true) {
                              authController.getUserStatus();
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
                          "Or continue with",
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
                            Get.offAllNamed(AppRouteNames().signUpScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Not a member?",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Register Now",
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

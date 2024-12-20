import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kamo/common/buttons/app_button.dart';
import 'package:kamo/common/textfields/app_textfield.dart';
import 'package:kamo/common/widgets/app_card_widget.dart';
import 'package:kamo/common/widgets/app_loading_hud.dart';
import 'package:kamo/features/vendor/home/controller/home_controller.dart';
import 'package:kamo/utils/assets/app_images.dart';
import 'package:kamo/utils/constants/app_constants.dart';
import 'package:kamo/utils/routes/route_names.dart';
import 'package:lottie/lottie.dart';
import '../../../../../utils/language/language_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController homeController;
  TextEditingController leadNumberController = TextEditingController();
  var localisationController =
      Get.put(LocalizationController(sharedPreferences: Get.find()));

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    homeController = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black54,
        backgroundColor: logoImageColor,
        title: Text(
          "title".tr,
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
              20.h.verticalSpace,
              // Text("${userModalConstant?.toJson()}")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Available",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  20.w.horizontalSpace,
                  Switch(
                    activeTrackColor: logoImageColor,
                    value: (userModalConstant?.isActive ?? false),
                    onChanged: (value) async {
                      await homeController.updateStatus();
                      setState(() {});
                    },
                  ),
                ],
              ),
              20.h.verticalSpace,
              AppCardWidget(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Text("${userModalConstant?.toJson()}"),
                      DetailRowWidget(
                        value1: "name".tr,
                        value2:
                            "${userModalConstant?.firstName?.capitalizeFirst ?? ""} ${userModalConstant?.lastName?.capitalizeFirst ?? ""}",
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
                      DetailRowWidget(
                        value1: "Points",
                        value2: "${userModalConstant?.points ?? 0} ",
                      ),
                    ],
                  ),
                ),
              ),
              20.h.verticalSpace,
              Row(
                children: [
                  Expanded(child: Lottie.asset(AppImages().leadsLottie)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          Text(
                            "wantToFixYourNextBooking".tr,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              5.verticalSpace,
              AppButton(
                title: "bookNow".tr,
                bColor: Colors.orange,
                onTap: () async {
                  //
                  await showModalBottomSheet(
                    backgroundColor: Colors.white,
                    showDragHandle: true,
                    // isScrollControlled: true,
                    scrollControlDisabledMaxHeightRatio: 0.8,
                    context: context,
                    builder: (context) {
                      return GetBuilder(
                          init: homeController,
                          builder: (controller) {
                            return AppLoadingHud(
                              isAsyncCall: controller.isLoading,
                              // isAsyncCall: true,
                              child: SingleChildScrollView(
                                child: InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: double.maxFinite,
                                    child: Column(
                                      children: [
                                        //

                                        SizedBox(
                                          height: 120,
                                          child: LottieBuilder.asset(
                                            AppImages().detailsLottie,
                                          ),
                                        ),
                                        Text(
                                          "kindlyProvideThePhoneNumberAssociatedWithYourAccount"
                                              .tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        10.h.verticalSpace,
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AppTextField(
                                                controller:
                                                    leadNumberController,
                                                autofocus: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText:
                                                    // "Reference Mobile Number",
                                                    "referenceMobileNo".tr,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  try {
                                                    if (leadNumberController
                                                            .text.length <
                                                        10) {
                                                      throw "Please fill number properly.";
                                                    } else {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      bool? res = await homeController
                                                          .addLead(
                                                              mobileNo: int.parse(
                                                                  leadNumberController
                                                                      .text));
                                                      if (res == true) {
                                                        leadNumberController
                                                            .clear();
                                                        Get.back();
                                                        Get.snackbar("Success",
                                                            "Tank you for sharing, your one more booking confirmed.");
                                                      }
                                                    }
                                                  } catch (e) {
                                                    Get.snackbar("Error", "$e");
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.arrow_forward,
                                                  size: 50,
                                                  color: logoImageColor,
                                                )),
                                            10.w.horizontalSpace,
                                          ],
                                        ),
                                        500.h.verticalSpace,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  );
                  //
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
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

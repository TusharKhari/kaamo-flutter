import 'dart:developer';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kamo/common/buttons/app_button.dart';
import 'package:kamo/common/dropdown/app_dropdown_widget.dart';
import 'package:kamo/common/widgets/app_loading_hud.dart';
import 'package:kamo/features/vendor/registration/controller/registration_controller.dart';
import 'package:kamo/features/vendor/registration/modals/categories_modal/subcategory.dart';
import 'package:kamo/features/vendor/registration/modals/registration_modal.dart';
import 'package:kamo/utils/constants/app_constants.dart';
import 'package:kamo/utils/routes/route_names.dart';

import '../../../../../common/textfields/app_textfield.dart';
import '../../modals/categories_modal/categories_modal.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationController registrationController;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  late bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    registrationController = Get.put(RegistrationController());
    Map? arg = Get.arguments;
    if (arg?["isEdit"] == true) {
      isEdit = true;
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        registrationController.getCategories();
        if (isEdit) {
          registrationController.registrationModal =
              userModalConstant ?? RegistrationModal();
          firstNameController.text =
              registrationController.registrationModal.firstName ?? "";
          lastNameController.text =
              registrationController.registrationModal.lastName ?? "";
          mobileNoController.text =
              registrationController.registrationModal.mobileNumber ?? "";
          streetController.text =
              registrationController.registrationModal.streetAddress ?? "";
          pinCodeController.text =
              registrationController.registrationModal.pinCode ?? "";
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void disp() {
    firstNameController.dispose();
    lastNameController.dispose();
    streetController.dispose();
    pinCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
            init: registrationController,
            builder: (controller) {
              return AppLoadingHud(
                isAsyncCall: controller.isLoading.value,
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        children: [
                          30.h.verticalSpace,
                          Text(
                            "letsSetUpYourAccount".tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                          Text(
                            "youreJustAFewStepsAwayFromJoiningUsFillOutTheDetailsBelowToCompleteYourRegistrationAndGetStarted"
                                .tr,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey[500],
                                    ),
                          ),
                          30.h.verticalSpace,
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Flexible(
                                child: AppTextField(
                                  padding: EdgeInsets.zero,
                                  controller: firstNameController,
                                  hintText: "firstName".tr,
                                  validator: (p0) {
                                    if (p0?.isEmpty ?? false) {
                                      return "";
                                    }
                                    return null;
                                  },
                                  onChanged: (p0) {
                                    controller.registrationModal = controller
                                        .registrationModal
                                        .copyWith(firstName: p0);
                                  },
                                ),
                              ),
                              30.w.horizontalSpace,
                              Flexible(
                                child: AppTextField(
                                  padding: EdgeInsets.zero,
                                  controller: lastNameController,
                                  hintText: "lastName".tr,
                                  onChanged: (p0) {
                                    controller.registrationModal = controller
                                        .registrationModal
                                        .copyWith(lastName: p0);
                                  },
                                ),
                              ),
                            ],
                          ),
                          20.h.verticalSpace,
                          AppTextField(
                            padding: EdgeInsets.zero,
                            controller: mobileNoController,
                            hintText: "mobileNumber".tr,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (p0) {
                              if (p0?.length != 10) {
                                return "";
                              }
                              return null;
                            },
                            onChanged: (p0) {
                              controller.registrationModal = controller
                                  .registrationModal
                                  .copyWith(mobileNumber: p0);
                            },
                          ),
                          20.h.verticalSpace,
                          AppTextField(
                            controller: streetController,
                            padding: EdgeInsets.zero,
                            hintText: "streetAddress".tr,
                            validator: (p0) {
                              if (p0?.isEmpty ?? false) {
                                return "";
                              }
                              return null;
                            },
                            onChanged: (p0) {
                              controller.registrationModal = controller
                                  .registrationModal
                                  .copyWith(streetAddress: p0);
                            },
                          ),
                          20.h.verticalSpace,
                          controller.isAddressByLocation == true
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      )
                                      //
                                      ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "${controller.registrationModal.city}, ${controller.registrationModal.state}"),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            controller.registrationModal =
                                                controller.registrationModal
                                                    .copyWith(
                                                        city: "", state: "");
                                            controller.isAddressByLocation =
                                                false;
                                            controller.update();
                                          },
                                          icon: Icon(Icons.close))
                                    ],
                                  ),
                                )
                              : Visibility(
                                  visible: true,
                                  child: Column(
                                    children: [
                                      // InkWell(
                                      //   onTap: () async {
                                      //     // var locD =
                                      //     //     await controller.getLocation();
                                      //     // controller.registrationModal =
                                      //     //     controller.registrationModal
                                      //     //         .copyWith(
                                      //     //             latitude:
                                      //     //                 "${locD?.latitude}",
                                      //     //             longitude:
                                      //     //                 "${locD?.longitude}");
                                      //     // List<Placemark> placemarks =
                                      //     //     await placemarkFromCoordinates(
                                      //     //         locD?.latitude ?? 52.2165157,
                                      //     //         locD?.longitude ?? 6.9437819);
                                      //     // if (placemarks.isNotEmpty) {
                                      //     //   Placemark pm = placemarks.first;
                                      //     //   log("message ${pm.toJson()}");
                                      //     //   controller.registrationModal = controller
                                      //     //       .registrationModal
                                      //     //       .copyWith(
                                      //     //           city:
                                      //     //               "${pm.name}, ${pm.street}, ${pm.subAdministrativeArea}",
                                      //     //           state:
                                      //     //               "${pm.locality}, ${pm.subLocality}, ${pm.thoroughfare}",
                                      //     //           pinCode: "${pm.postalCode}");
                                      //     //   controller.isAddressByLocation = true;
                                      //     //   controller.update();
                                      //     // }
                                      //   },
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.end,
                                      //     children: [
                                      //       Text(
                                      //         "useMyLocation".tr,
                                      //         style: Theme.of(context)
                                      //             .textTheme
                                      //             .bodyLarge
                                      //             ?.copyWith(
                                      //               color: Colors.grey[500],
                                      //             ),
                                      //       ),
                                      //       5.w.horizontalSpace,
                                      //       Icon(
                                      //         Icons.my_location_outlined,
                                      //         color: Colors.blue[400],
                                      //         size: 25,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // 20.h.verticalSpace,
                                      CSCPicker(
                                        defaultCountry: CscCountry.India,
                                        disableCountry: true,
                                        disabledDropdownDecoration:
                                            BoxDecoration(
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.white,
                                                )),
                                        dropdownDecoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onCountryChanged: (value) {},
                                        onStateChanged: (value) {
                                          log("message $value");
                                          controller.registrationModal =
                                              controller.registrationModal
                                                  .copyWith(state: value);
                                        },
                                        onCityChanged: (value) {
                                          log("message $value");
                                          controller.registrationModal =
                                              controller.registrationModal
                                                  .copyWith(city: value);
                                        },
                                      ),
                                      20.h.verticalSpace,
                                      AppTextField(
                                        controller: pinCodeController,
                                        padding: EdgeInsets.zero,
                                        hintText: "pinCode".tr,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(6),
                                        ],
                                        validator: (p0) {
                                          if (p0?.length != 6) {
                                            return "";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        onChanged: (p0) {
                                          controller.registrationModal =
                                              controller.registrationModal
                                                  .copyWith(pinCode: p0);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                          10.h.verticalSpace,
                          AppDropDownWidget(
                            title: "workType".tr,
                            selectedTitle:
                                controller.registrationModal.workingLevel1,
                            options: [],
                            items: controller.categoriesList
                                .map(
                                  (e) => DropdownMenuItem<CategoriesModal>(
                                      value: e, child: Text("${e.name}")),
                                )
                                .toList(),
                            onChanged: (p0) {
                              if (p0 is CategoriesModal) {
                                controller.selectCategory(selectedCat: p0);
                                controller.update();
                              }
                            },
                          ),
                          (controller.registrationModal.workingLevel1
                                      ?.contains("other") ??
                                  false)
                              ? Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: AppTextField(
                                    padding: EdgeInsets.zero,
                                    onChanged: (p0) {
                                      controller.selectSubCategory(
                                          selectedCat: p0);
                                    },
                                    hintText: "Working Category Name",
                                  ),
                                )
                              : Visibility(
                                  visible:
                                      controller.subCategoriesList.isNotEmpty,
                                  child: AppDropDownWidget(
                                    selectedTitle: controller
                                        .registrationModal.workingLevel2,
                                    options: [],
                                    items: controller.subCategoriesList
                                        .map(
                                          (e) => DropdownMenuItem<Subcategory>(
                                              value: e,
                                              child: Text("${e.name}")),
                                        )
                                        .toList(),
                                    onChanged: (p0) {
                                      if (p0 is Subcategory) {
                                        controller.selectSubCategory(
                                            selectedCat: p0.name ?? "");
                                      }
                                    },
                                  ),
                                ),
                          30.h.verticalSpace,
                          AppButton(
                            title: isEdit ? "edit".tr : "submit".tr,
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              var res = isEdit
                                  ? await controller.updateUser()
                                  : await controller.registerUser();
                              if (res == true) {
                                Get.offAllNamed(AppRouteNames().homeScreen);
                              }
                              // controller.sendData();
                            },
                          ),
                          40.h.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kamo/common/widgets/app_loading_hud.dart';
import 'package:kamo/features/user/vendor_display/controller/vendors_show_controller.dart';
import 'package:kamo/utils/constants/app_constants.dart';

class VendorsShowScreen extends StatefulWidget {
  const VendorsShowScreen({super.key});

  @override
  State<VendorsShowScreen> createState() => _VendorsShowScreenState();
}

class _VendorsShowScreenState extends State<VendorsShowScreen> {
  late VendorsShowController vendorsShowController;
  late ScrollController scrollController;
  late final TextEditingController searchController;
  int selectedIdx = -1;
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() {
    vendorsShowController = Get.put(VendorsShowController());
    scrollController = ScrollController();
    searchController = TextEditingController();
    Future.wait([
      vendorsShowController.fetchUsers(),
      vendorsShowController.getCategories()
    ]);
    scrollController.addListener(
      () {
        final scrollPosition = scrollController.position.pixels;
        if (scrollPosition >= scrollController.position.maxScrollExtent) {
          vendorsShowController.fetchUsers();
          // vendorsShowController.getCategories();
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void dsp() {
    scrollController.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "title".tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: GetBuilder(
          init: vendorsShowController,
          builder: (controller) {
            return SafeArea(
              child: AppLoadingHud(
                isAsyncCall: controller.isLoading.value,
                child: SingleChildScrollView(
                  // controller: scrollController,
                  child: Column(
                    children: [
                      30.h.verticalSpace,
                      //
                      //
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.categoriesList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var det = controller.categoriesList[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIdx = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedIdx != index
                                          ? logoImageColor
                                          : Colors.transparent,
                                      // color: Colors.grey
                                    ),
                                    //
                                    color: selectedIdx == index
                                        ? Colors.grey
                                        : null,
                                    borderRadius: BorderRadius.circular(8)),
                                width: 150,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                  "${det.name}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            );
                          },
                        ),
                      ),
                      15.h.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SearchBar(
                          controller: searchController,
                          trailing: [
                            IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  searchController.clear();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ))
                          ],
                          onChanged: (value) {
                            setState(() {
                              // searchQuery = value;
                            });
                          },
                          hintText: "searchLocation".tr,
                          leading: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                      15.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: (selectedIdx != -1),
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  selectedIdx = -1;
                                });
                              },
                              child: Text(
                                "${"clearFilter".tr}    ",
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      30.h.verticalSpace,
                      //
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: vendorsShowController.usersList.length,
                        itemBuilder: (context, index) {
                          var user = vendorsShowController.usersList[index];
                          return Visibility(
                            visible: ((selectedIdx != -1
                                    ? user.workingLevel1 ==
                                        vendorsShowController
                                            .categoriesList[selectedIdx].name
                                    : true) &&
                                ((user.fullAddress
                                            ?.toLowerCase()
                                            .contains(searchController.text) ??
                                        false) ||
                                    (user.streetAddress
                                            ?.toLowerCase()
                                            .contains(searchController.text) ??
                                        false) ||
                                    (user.city
                                            ?.toLowerCase()
                                            .contains(searchController.text) ??
                                        false) ||
                                    (user.state
                                            ?.toLowerCase()
                                            .contains(searchController.text) ??
                                        false) ||
                                    (user.pinCode
                                            ?.toLowerCase()
                                            .contains(searchController.text) ??
                                        false))),
                            child: Card(
                              // surfaceTintColor: Colors.amber,
                              margin: EdgeInsets.symmetric(horizontal: 15)
                                  .copyWith(bottom: 20),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    //
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "address".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: 18,
                                              ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${user.fullAddress}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontSize: 18,
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    //
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "work".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: 18,
                                              ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          "${user.workingLevel1} (${user.workingLevel2})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: 18,
                                              ),
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    //
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "contact".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: 18,
                                              ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            vendorsShowController.makingPhoneCall(
                                                phoneNo: (((user.fullAddress?.toLowerCase().contains("solan") ?? false) ||
                                                            (user.fullAddress
                                                                    ?.toLowerCase()
                                                                    .contains(
                                                                        "shimla") ??
                                                                false)) ||
                                                        ((user.city?.toLowerCase().contains("solan") ?? false) ||
                                                            (user.city?.toLowerCase().contains("shimla") ??
                                                                false)) ||
                                                        ((user.pinCode?.toLowerCase().contains("173211") ?? false) ||
                                                            (user.pinCode
                                                                    ?.toLowerCase()
                                                                    .contains(
                                                                        "1710") ??
                                                                false)) ||
                                                        ((user.city?.toLowerCase().contains("173212") ??
                                                                false) ||
                                                            (user.city
                                                                    ?.toLowerCase()
                                                                    .contains("1710") ??
                                                                false)))
                                                    ? (user.callingMobileNumber ?? "")
                                                    : (user.mobileNumber ?? ""));
                                          },
                                          icon: Icon(
                                            Icons.phone_in_talk_sharp,
                                          ),
                                        )
                                      ],
                                    ),
                                    //
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

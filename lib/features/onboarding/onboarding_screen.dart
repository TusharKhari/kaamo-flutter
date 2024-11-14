import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kamo/utils/assets/app_images.dart';
import 'package:kamo/utils/routes/route_names.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants/app_constants.dart';
import '../vendor/auth/controllers/auth_controller.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  late final AuthController authController;


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
        authController.getUserStatus();
      },
    );
  }

  void _onIntroEnd(context) {
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => const HomePage()),
    // );
    Get.offAllNamed(AppRouteNames().chooseTypeScreen);
    // Get.offAllNamed(AppRouteNames().signUpScreen);
  }

  Widget _buildImage(
    String assetName,
  ) {
    return Lottie.asset(assetName, width: 350.w);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          infiniteAutoScroll: true,
          // globalHeader: Align(
          //   alignment: Alignment.topRight,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 16, right: 16),
          //       child: _buildImage('flutter.png', 100),
          //     ),
          //   ),
          // ),
          globalFooter: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              child: Text(
                'Let\'s go right away!',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: logoImageColor),
              ),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
          pages: [
            PageViewModel(
              title: "Welcome to Kaamo Events!",
              body:
                  "Vendors, register and showcase your services; users, discover the best vendors for your event!",
              image: _buildImage(AppImages().welcomeLottie),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Easy to use !",
              body:
                  "A seamless experience for both vendors and planners—find, book, and connect!",
              image: _buildImage(AppImages().weddingLottie),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Wide reach !",
              body:
                  "Reach more clients. Register your services and get noticed by event planners.",
              image: _buildImage(AppImages().findingLottie),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () =>
              _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          //rtl: true, // Display as right-to-left

          back: const Icon(Icons.arrow_back),
          skip: Text('Skip',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: logoImageColor)),

          next: const Icon(Icons.arrow_forward),
          done: Text('Done',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: logoImageColor)),
          nextStyle:
              ButtonStyle(iconColor: WidgetStatePropertyAll(logoImageColor)),
          skipStyle:
              ButtonStyle(iconColor: WidgetStatePropertyAll(logoImageColor)),
          doneStyle:
              ButtonStyle(iconColor: WidgetStatePropertyAll(logoImageColor)),

          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.white,
            activeColor: logoImageColor,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}

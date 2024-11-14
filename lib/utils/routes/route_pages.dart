import 'package:get/get.dart';
import 'package:kamo/utils/routes/route_names.dart';

import '../../features/onboarding/choose_type_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/user/vendor/presentation/screens/vendors_show_screen.dart';
import '../../features/vendor/auth/presentation/screens/login_screen.dart';
import '../../features/vendor/auth/presentation/screens/sign_up_screen.dart';
import '../../features/vendor/home/presentation/screens/home_screen.dart';
import '../../features/vendor/registration/presentation/widgets/registration_screen.dart';
import '../../features/vendor/settings/presentation/screens/settings_screen.dart';

var routesPages = [
  GetPage(
    name: AppRouteNames().loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRouteNames().signUpScreen,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: AppRouteNames().registrationScreen,
    page: () => const RegistrationScreen(),
  ),
  GetPage(
    name: AppRouteNames().homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: AppRouteNames().settingScreen,
    page: () => const SettingScreen(),
  ),
  GetPage(
    name: AppRouteNames().vendorsShowScreen,
    page: () => const VendorsShowScreen(),
  ),
  GetPage(
    name: AppRouteNames().onboardingScreen,
    page: () => const OnboardingScreen(),
  ),
  GetPage(
    name: AppRouteNames().chooseTypeScreen,
    page: () => const ChooseTypeScreen(),
  ),
];

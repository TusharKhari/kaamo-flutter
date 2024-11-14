class AppRouteNames {
  static final AppRouteNames _singleton = AppRouteNames._internal();

  factory AppRouteNames() {
    return _singleton;
  }

  AppRouteNames._internal();

  String loginScreen = "/LoginScreen";
  String signUpScreen = "/SignUpScreen";
  String registrationScreen = "/RegistrationScreen";
  String homeScreen = "/HomeScreen";
  String settingScreen = "/SettingScreen";
  String vendorsShowScreen = "/VendorsShowScreen";
  String onboardingScreen = "/OnboardingScreen";
  String chooseTypeScreen = "/ChooseTypeScreen";
}

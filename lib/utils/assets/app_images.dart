class AppImages {
  static final AppImages _singleton = AppImages._internal();

  factory AppImages() {
    return _singleton;
  }

  AppImages._internal();
  String findingLottie ="assets/images/finding.json";
  String weddingLottie ="assets/images/wedding-shoot.json";
  String welcomeLottie ="assets/images/welcome_lottie.json";
  String leadsLottie ="assets/images/leads_lottie.json";
}

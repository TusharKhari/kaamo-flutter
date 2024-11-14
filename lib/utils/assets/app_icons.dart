class AppIcons {
  static final AppIcons _singleton = AppIcons._internal();

  factory AppIcons() {
    return _singleton;
  }

  AppIcons._internal();

  String googleLogoSvg = "assets/icons/google_icon.svg";
}

import 'package:flutter/material.dart';
import 'package:kamo/features/vendor/registration/modals/registration_modal.dart';
import 'package:kamo/utils/assets/app_icons.dart';
import 'package:kamo/utils/assets/app_images.dart';
import 'package:kamo/utils/validators/app_validators.dart';

import '../language/language_model.dart';

AppIcons appIconsConstant = AppIcons();
AppImages appImagesConstant = AppImages();
AppValidators appValidatorsConstant = AppValidators();
RegistrationModal? userModalConstant;
Color logoImageColor =  Color.fromRGBO(173, 204, 83, 1);

class AppConstants {
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      // imageUrl: "🇺🇸",
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      // imageUrl: "🇵🇰",
      languageName: 'Hindi',
      countryCode: 'IN',
      languageCode: 'hi',
    ),
  ];
}













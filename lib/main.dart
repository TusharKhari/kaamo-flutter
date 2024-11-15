import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamo/firebase_options.dart';
import 'utils/constants/app_constants.dart';
import 'utils/language/language_controller.dart';
import 'utils/language/messages.dart';
import 'utils/routes/route_names.dart';
import 'utils/routes/route_pages.dart';
import 'utils/language/dependency_inj.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> _languages = await dep.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return
        //
        ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GetBuilder<LocalizationController>(
                  builder: (localizationController) {
                return GetMaterialApp(
                  locale: localizationController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                      AppConstants.languages[0].countryCode),
                  // initialRoute: AppRouteNames().registrationScreen,
                  initialRoute: AppRouteNames().onboardingScreen,
                  // initialRoute: AppRouteNames().signUpScreen,
                  getPages: routesPages,
                  debugShowCheckedModeBanner: false,
                  title: 'First',
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.grey[300],
                    textTheme: GoogleFonts.openSansTextTheme(
                      Theme.of(context).textTheme.copyWith(),
                    ),
                    useMaterial3: true,
                  ),
                  home: child,
                );
              });
            }

            // child: const LoginScreen(),
            );
  }
}

/* */

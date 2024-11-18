import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamo/firebase_options.dart';
import 'utils/routes/route_names.dart';
import 'utils/routes/route_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return
        //
        ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
           // initialRoute: AppRouteNames().registrationScreen,
          initialRoute: AppRouteNames().onboardingScreen,
          // initialRoute: AppRouteNames().signUpScreen,
          getPages: routesPages,
          debugShowCheckedModeBanner: false,
          title: 'KAAMO EVENTS',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[300],
            textTheme: GoogleFonts.openSansTextTheme(
              Theme.of(context).textTheme.copyWith(),
            ),
            useMaterial3: true,
          ),
          home: child,
        );
      },
      // child: const LoginScreen(),
    );
  }
}

/* */

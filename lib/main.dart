import 'package:fbus_app/src/const/colors.dart';
import 'package:fbus_app/src/home/main_screen.dart';
import 'package:fbus_app/src/pages/landingPage/landing_page.dart';
import 'package:fbus_app/src/pages/loginByDriver/login.dart';
import 'package:fbus_app/src/pages/onboard/intro_page.dart';
import 'package:fbus_app/src/pages/sentOtp/sent_otp_page.dart';
import 'package:fbus_app/src/pages/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? isviewed;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from SharedPreferences
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isviewed = prefs.getInt('onBoard');
      print('aaaaa $isviewed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'F-BUS',
      debugShowCheckedModeBanner: false,
      initialRoute: isviewed == 0 ? '/splash' : '/onboard',
      getPages: [
        GetPage(name: '/', page: () => LandingPage()),
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/onboard', page: () => IntroPage()),
        GetPage(name: '/login-by-driver', page: () => LoginPage()),
        GetPage(name: '/sent-otp', page: () => SendOTPPage()),
        GetPage(name: '/home', page: () => const MainPage()),
      ],
      theme: ThemeData(
          fontFamily: "Metropolis",
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppColor.orange,
              ),
              shape: MaterialStateProperty.all(
                const StadiumBorder(),
              ),
              elevation: MaterialStateProperty.all(0),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                AppColor.orange,
              ),
            ),
          ),
          primaryColor: AppColor.orange,
          colorScheme: const ColorScheme(
            primary: AppColor.orange,
            secondary: Colors.amberAccent,
            brightness: Brightness.light,
            onBackground: Colors.grey,
            onPrimary: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
            onSecondary: Colors.grey,
            background: Colors.grey,
          )),
      navigatorKey: Get.key,
    );
  }
}

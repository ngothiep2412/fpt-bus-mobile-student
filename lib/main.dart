import 'package:fbus_app/src/assets/constant.dart';
import 'package:fbus_app/src/home/main_screen.dart';
import 'package:fbus_app/src/pages/login/login_page.dart';
import 'package:fbus_app/src/pages/onboard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('User id: ${userSession.id}');

    return GetMaterialApp(
      title: 'Delivery Udemy',
      debugShowCheckedModeBanner: false,
      // initialRoute: userSession.id != null ? '/homne' : '/',
      initialRoute: isviewed != 0 ? '/' : '/onboard',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/onboard', page: () => const OnboardPage()),
        // GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => const MainPage()),
      ],
      theme: ThemeData(
          primaryColor: primary,
          colorScheme: ColorScheme(
            primary: primary,
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

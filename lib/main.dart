import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '././src/const/colors.dart';
import '././src/models/users.dart';
import '././src/pages/home/home_page.dart';
import '././src/pages/landingPage/landing_page.dart';
import '././src/pages/loginByDriver/login.dart';
import '././src/pages/onboard/intro_page.dart';
import '././src/pages/profile/profile_page.dart';
import '././src/pages/sentOtp/sent_otp_page.dart';
import '././src/pages/splashScreen/splash_screen.dart';
import '././src/providers/push_notifications_provider.dart';
import '././src/utils/firebase_config.dart';

// Get userSession from getStorage to use.
UserModel userSession = UserModel.fromJson(GetStorage().read('user') ?? {});
PushNotificationsProvider pushNotificationsProvider =
    PushNotificationsProvider();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Recibiendo notificacion en segundo plano ${message.messageId}');
  // pushNotificationsProvider.showNotification(message);
}

const storage = FlutterSecureStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    name: 'f-bus',
    options: FirebaseConfig.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initPushNotifications();
  FirebaseMessaging.instance.getToken().then((value) async {
    await storage.write(key: 'firebaseToken', value: value);
    print('getToken: $value');
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<int> _onBoardFuture;
  @override
  void initState() {
    _onBoardFuture = _loadData();
    pushNotificationsProvider.onMessageListener();
    super.initState();
  }

  // Load data from SharedPreferences to get key: onBoard
  Future<int> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('onBoard') ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _onBoardFuture,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool isViewed = snapshot.data == null ? false : snapshot.data == 0;
          String initialRoute;
          if (userSession.id != null) {
            initialRoute = '/splash';
          } else {
            initialRoute = isViewed ? '/splash' : '/intro';
          }
          return GetMaterialApp(
            title: 'F-BUS',
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            getPages: [
              GetPage(name: '/', page: () => LandingPage()),
              GetPage(name: '/intro', page: () => IntroPage()),
              GetPage(name: '/splash', page: () => SplashScreen()),
              GetPage(name: '/home', page: () => HomePage()),
              GetPage(name: '/sent-otp', page: () => SendOTPPage()),
              GetPage(name: '/login-by-driver', page: () => LoginPage()),
              GetPage(name: '/profile', page: () => ProfilePage()),
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
        } else {
          // While data is loading, display a loading indicator
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

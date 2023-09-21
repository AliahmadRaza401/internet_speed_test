import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_speedtest_app/ads_services/ads_services.dart';
// import 'package:internet_speed/ads_services/ads_services.dart';
import 'package:internet_speedtest_app/models/wifi_Resut_Model.dart';
import 'package:internet_speedtest_app/provider/all_providers.dart';
import 'package:internet_speedtest_app/provider/internet_connection_provider.dart';
import 'package:internet_speedtest_app/services/fcm_services.dart';
import 'package:internet_speedtest_app/task/login.dart';
import 'package:internet_speedtest_app/task/navi_bar.dart';
import 'package:internet_speedtest_app/task/singUp.dart';
import 'package:permission_handler/permission_handler.dart';
import './screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMServices.listenAppFCM();

  FirebaseMessaging.onBackgroundMessage(
      (message) => FCMServices.listenbackgroundFCM(message));
  FirebaseMessaging.instance.subscribeToTopic("users");
  FCMServices.listenAppFCM();
  AdsServices.adsInitialize();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(WifiResultModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // requestPermissions();
  }

  // Future<void> requestStoragePermission() async {
  //   final PermissionStatus status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     // Permission granted, access storage
  //     // accessStorage();
  //   } else {
  //     // Permission denied, handle accordingly
  //     print('Storage permission not granted');
  //   }
  // }

  // Future<void> requestPermissions() async {
  //   requestStoragePermission();
  // }

  void handlePermissionStatus(Map<Permission, PermissionStatus> status) {
    if (status[Permission.storage]!.isGranted) {
      // accessStorage();
      log('Storage Permission is granted');
    } else {
      // Display error or prompt user to grant permission
      print('Storage permission not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
            providers: allProvider,
            child: Consumer<InternetConnectionProvider>(
                builder: (context, state, child) {
              Timer.run(() {
                Provider.of<InternetConnectionProvider>(context, listen: false)
                    .initStateNetCheck(context);
              });
              return MaterialApp(
                color: Colors.red,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                home:
                    // MyNavigationBarScreen(),
                    // Login(),
                    SignupPage(),
                // const SplashScreen(),
              );
            }));
      },
    );
  }
}

import 'package:internet_speedtest_app/provider/home_provider.dart';
import 'package:internet_speedtest_app/provider/internet_connection_provider.dart';
import 'package:internet_speedtest_app/provider/phone_provider.dart';
import 'package:internet_speedtest_app/provider/wifi_provider.dart';
import 'package:provider/provider.dart';

var allProvider = [
  ChangeNotifierProvider<HomeProvider>(
    create: (_) => HomeProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<InternetConnectionProvider>(
    create: (_) => InternetConnectionProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<PhoneProvider>(
    create: (_) => PhoneProvider(),
    lazy: true,
  ),
   ChangeNotifierProvider<WifiProvider>(
    create: (_) => WifiProvider(),
    lazy: true,
  ),
];

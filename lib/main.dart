import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:untitled/core/utils/network/global_network_observer.dart';
import 'package:untitled/core/utils/network/view_models/connectivity_view_model.dart';
import 'package:untitled/features/auth/presentation/pages/login_page.dart';
import 'package:untitled/features/auth/presentation/view_models/login_view_model.dart';
import 'package:untitled/features/auth/presentation/view_models/register_view_model.dart';

import 'domain/models/user/user.dart';
import 'features/splash_page.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {

  dotenv.load(fileName: '.env');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light, // nền sáng
    statusBarIconBrightness: Brightness.dark, // icon màu tối
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ConnectivityViewModel())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Bkav Chat',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: GlobalNetworkObserver(
          child: SplashPage(), // hoặc NavigationWrapper nếu có nhiều page
        ),
      ),
    );
  }
}
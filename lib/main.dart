import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/features/auth/presentation/pages/login_page.dart';
import 'package:untitled/features/auth/presentation/view_models/login_view_model.dart';
import 'package:untitled/features/auth/presentation/view_models/register_view_model.dart';
import 'package:untitled/features/chat/presentation/pages/chat_page.dart';
import 'package:untitled/features/home/presentaion/pages/home_page.dart';
import 'package:untitled/utils/network/global_network_observer.dart';
import 'package:untitled/utils/network/view_models/connectivity_view_model.dart';


void main() {
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
        debugShowCheckedModeBanner: false,
        title: 'Bkav Chat',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: GlobalNetworkObserver(
          child: HomePage(), // hoặc NavigationWrapper nếu có nhiều page
        ),
      ),
    );
  }
}
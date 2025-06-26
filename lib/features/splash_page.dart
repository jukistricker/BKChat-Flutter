import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/features/auth/presentation/pages/login_page.dart';


import '../core/config/app.config.dart';
import '../core/services/auth_http_service.dart';
import 'home/presentaion/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      _goTo(const LoginPage());
      return;
    }

    try {
      final response = await AuthHttpService.getAuth(ApiConfig.checkUrl);

      if (response.statusCode == 200) {
        _goTo(const HomePage());
      } else {
        await _showSessionExpiredDialog();
        await prefs.clear();
        _goTo(const LoginPage());
      }
    } catch (e) {
      await _showSessionExpiredDialog();
      await prefs.clear();
      _goTo(const LoginPage());
    }
  }

  Future<void> _showSessionExpiredDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Phiên hết hạn'),
        content: const Text('Vui lòng đăng nhập lại.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _goTo(Widget page) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

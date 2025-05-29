import 'package:flutter/material.dart';
import 'package:untitled/core/constants/constants.dart';
import 'package:untitled/features/auth/presentation/pages/register_page.dart';
import 'package:untitled/features/auth/presentation/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const LoginPage(),
  );

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;        // lấy kích thước màn hình
    final padding = MediaQuery.of(context).padding;  // lấy padding an toàn (status bar...)

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            // Title "Bkav Chat"
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                Constants.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff146ae0),
                ),
              ),
            ),

// Label "Tài khoản"
            Positioned(
              top: size.height * 0.33,
              left: 24,
              child: Text(
                Constants.username,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

// Input text cho "Tài khoản"
            Positioned(
              top: size.height * 0.36,
              left: 24,
              right: 24,
              child: TextField(
                onChanged: (value) => viewModel.setUsername(value),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffcdd1d0),
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffcdd1d0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff6783e7),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),

            // Label "Mật khẩu"
            Positioned(
              top: size.height * 0.43,
              left: 26,
              child: Text(
                Constants.password,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

// Input text cho "Mật khẩu"
            Positioned(
              top: size.height * 0.46,
              left: 24,
              right: 24,
              child: TextField(
                onChanged: (value) => viewModel.setPassword(value),
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffcdd1d0),
                      width: 1,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffcdd1d0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff6783e7),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),

            if (viewModel.errorText != null)
              Positioned(
                top: size.height * 0.63,
                left: 24,
                right: 24,
                child: Text(
                  viewModel.errorText!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),

            // "Login" button with onTap
            Positioned(
              bottom: size.height * 0.09,  // đặt nút cách đáy màn hình khoảng 9%
              left: 24,
              right: 24,
              height: 48,
              child: GestureDetector(
                onTap: () {
                  final success=viewModel.signIn();
                  if (success) {
                    viewModel.setErrorText(null);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(Constants.loginSuccess)),
                    );
                    // Có thể chuyển sang HomePage ở đây nếu muốn
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff6783e7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      Constants.login,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // "Đăng ký" button
            Positioned(
              bottom: size.height * 0.03,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, RegisterPage.route());
                  },
                  child: Text(
                    Constants.register,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff047de7),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

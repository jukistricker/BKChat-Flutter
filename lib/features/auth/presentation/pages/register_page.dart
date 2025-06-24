import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/constants/constants.dart';
import 'package:untitled/features/home/presentaion/pages/home_page.dart';
import '../../../../core/utils/realm_service.dart';
import '../view_models/register_view_model.dart';

class RegisterPage extends StatelessWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const RegisterPage(),
  );

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.arrow_back),
                ),
              ),

              SizedBox(height: 40),

              // Title
              Center(
                child: Text(
                  Constants.createAccount,
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 48),
              //fullname
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0), // căn lề như Figma
                    child: Text(
                      Constants.fullname,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Input Text
                  TextField(
                    onChanged: (value) => viewModel.setDisplayName(value),
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
                ],
              ),


              SizedBox(height: 12),

              // Username
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0), // căn lề như Figma
                    child: Text(
                      Constants.username,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Input Text
                  TextField(
                    onChanged: (value) => viewModel.setUsername(value),
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
                ],
              ),

              SizedBox(height: 12),

              // Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0), // căn lề như Figma
                    child: Text(
                      Constants.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Input Text
                  TextField(
                    onChanged: (value) => viewModel.setEmail(value),
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
                ],
              ),

              SizedBox(height: 12),
              // Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label "Mật khẩu"
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0), // căn lề như Figma
                    child: Text(
                      Constants.password,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Input Text cho "Mật khẩu"
                  TextField(
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
                ],
              ),


              SizedBox(height: 12),

              // Re-type Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label "Mật khẩu"
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0), // căn lề như Figma
                    child: Text(
                      Constants.reTypePassword,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Input Text cho "Mật khẩu"
                  TextField(
                    onChanged: (value) => viewModel.setConfirmPassword(value),
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
                ],
              ),
              // Cách đều errorText
              SizedBox(height: 100),

              if (viewModel.errorText != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center( // 👈 Thêm Center để căn giữa ngang
                    child: Text(
                      viewModel.errorText!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

// Cách đều errorText với nút
              SizedBox(height: 24),
              Spacer(),
              // Register button
              GestureDetector(
                onTap: () async {
                  final realm = RealmService().realm;
                  final success = await viewModel.signUp(realm);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(Constants.registering)),
                  );
                  if (success) {
                    viewModel.setErrorText(null);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(Constants.registerSuccess)),
                    );
                    Navigator.push(context, HomePage.route());
                    // Có thể chuyển sang HomePage ở đây nếu muốn
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xff6783e7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      Constants.createAccount,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

}

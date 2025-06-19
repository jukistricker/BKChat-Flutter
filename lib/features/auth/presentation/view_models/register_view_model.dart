import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:untitled/features/auth/data/req/RegisterRequest.dart';

class RegisterViewModel extends ChangeNotifier {
  // String displayName = '';
  // String email='';
  // String username = '';
  // String password = '';
  // String confirmPassword = '';
  final RegisterRequest _request = RegisterRequest();
  String? errorText;

  void setEmail(String value){
    _request.email = value;
    notifyListeners();
  }

  void setUsername(String value) {
    _request.username = value;
    notifyListeners();
  }

  void setDisplayName(String value) {
    _request.displayName = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _request.confirmPassword = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _request.password = value;
    notifyListeners();
  }

  void setErrorText(String? value) {
    errorText = value;
    notifyListeners();
  }


  Future<bool> signUp() async {
    if (!_request.isValid()) {
      setErrorText('Vui lòng nhập đầy đủ các trường!');
      return false;
    } else if (_request.username == 'admin' &&
        _request.password == '12345678' &&
        _request.password == _request.confirmPassword) {
      setErrorText('Tài khoản đã tồn tại !');
      return false;
    } else if (!_request.isPasswordConfirmed()) {
      setErrorText('Mật khẩu không khớp!');
      return false;
    } else {
      final url = Uri.parse('http://10.2.44.52:8888/api/auth/register');

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(_request.toJson()),
        );

        final json = jsonDecode(response.body);
        if (json['status'] == 1) {
          final token = json['data']['token'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token); // ✅ Lưu token vào local

          // In ra cho chắc
          print('Saved token: $token');
          print('Token: ${json['data']['token']}');
          print('Username: ${json['data']['Username']}');
          print('FullName: ${json['data']['FullName']}');
          return true;
        } else {
          setErrorText(json['meessage'] ?? json['message'] ?? 'Đăng ký thất bại');
          return false;
        }
      } catch (e) {
        setErrorText('Lỗi kết nối máy chủ');
        return false;
      }
    }
  }
}

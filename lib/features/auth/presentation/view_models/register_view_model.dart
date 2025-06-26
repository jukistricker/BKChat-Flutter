import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled/core/config/app.config.dart';

import 'package:untitled/features/auth/data/req/register_request.dart';

import '../../../../domain/models/user/user.dart';

class RegisterViewModel extends ChangeNotifier {
  // String displayName = '';
  // String email='';
  // String username = '';
  // String password = '';
  // String confirmPassword = '';
  final RegisterRequest _request = RegisterRequest();
  String? errorText;



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


  Future<bool> signUp(Realm realm) async {
    if (!_request.isValid()) {
      setErrorText('Vui lòng nhập đầy đủ các trường!');
      return false;
    } else if (_request.username == 'admin' &&
        _request.password == '12345678' &&
        _request.password == _request.confirmPassword) {
      setErrorText('Tài khoản đã tồn tại!');
      return false;
    } else if (!_request.isPasswordConfirmed()) {
      setErrorText('Mật khẩu không khớp!');
      return false;
    } else {
      final url = Uri.parse(ApiConfig.regUrl);

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(_request.toJson()),
        );

        final json = jsonDecode(response.body);
        if (json['status'] == 1) {
          final data = json['data'];
          final token = data['token'];

          // ✅ Lưu token vào SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);

          // ✅ Lưu user vào Realm
          final user = User(
            ObjectId(),
            data['userId'] ?? '',          // hoặc '', nếu chưa có
            data['Username'] ?? _request.username,
            data['FullName'] ?? _request.displayName,
            DateTime.now(),
            avatarPath: null,
          );

          realm.write(() {
            realm.add(user);
          });

          print('User saved to Realm: ${user.username}');
          print('Saved token: $token');

          return true;
        } else {
          setErrorText(json['message'] ?? 'Đăng ký thất bại');
          return false;
        }
      } catch (e) {
        setErrorText('Lỗi kết nối máy chủ');
        print('Lỗi: ${e.toString()}');
        return false;
      }
    }
  }

}

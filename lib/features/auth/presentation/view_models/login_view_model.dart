import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/core/config/app.config.dart';
import 'package:untitled/features/auth/data/req/login_request.dart';

import '../../../../core/services/auth_http_service.dart';
import '../../../../domain/models/user/user.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRequest _request = LoginRequest();

  String? errorText;

  void setUsername(String value) {
    _request.username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _request.password = value;
    notifyListeners();
  }

  void setErrorText(String? value){
    errorText=value;
    notifyListeners();
  }

  Future<bool> signIn(Realm realm) async {
    if(_request.username==''&&_request.password!=''){
      errorText = 'Tên đăng nhập không được để trống';
      notifyListeners();
      return false;
    }
    else if(_request.username!=''&&_request.password==''){
      errorText = 'Mật khẩu không được để trống';
      notifyListeners();
      return false;
    }
    else if(_request.username==''&&_request.password==''){
      errorText = 'Tên đăng nhập và mật khẩu không được để trống';
      notifyListeners();
      return false;
    }
    else {


      try {
        final res = await AuthHttpService.post(ApiConfig.loginUrl,_request.toJson());

        print('Gửi request: ${jsonEncode(_request.toJson())}');

        AuthHttpService.logCurlRequest(ApiConfig.loginUrl, _request.toJson());
        print(res.body);
        final json = jsonDecode(res.body);
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
            data['FullName'] ?? '',
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

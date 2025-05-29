import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String username = '';
  String password = '';
  String? errorText;

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setErrorText(String? value){
    errorText=value;
    notifyListeners();
  }

  bool signIn() {
    if (username == 'admin' && password == '12345678') {
      // TODO: implement sign-up logic with validation and API call
      print('Signing up with $username / $password ');
      notifyListeners();
      return true;
    }
    else if(username==''&&password!=''){
      errorText = 'Tên đăng nhập không được để trống';
      notifyListeners();
      return false;
    }
    else if(username!=''&&password==''){
      errorText = 'Mật khẩu không được để trống';
      notifyListeners();
      return false;
    }
    else if(username==''&&password==''){
      errorText = 'Tên đăng nhập và mật khẩu không được để trống';
      notifyListeners();
      return false;
    }
    else {
      errorText = 'Bạn nhập sai tên tài khoản hoặc mật khẩu!';
      notifyListeners();
      return false;
    }

  }
}

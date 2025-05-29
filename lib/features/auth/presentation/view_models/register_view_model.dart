import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  String displayName = '';
  String username = '';
  String password = '';
  String confirmPassword = '';
  String? errorText;

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setDisplayName(String value) {
    displayName = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setErrorText(String? value) {
    errorText = value;
    notifyListeners();
  }


  bool signUp() {
    if(username==''||displayName==''||password==''||confirmPassword==''){
      errorText='Vui lòng nhập đầy đủ các trường!';
      notifyListeners();
      return false;
    }
    else if(username=='admin'&&password=='12345678'&&password==confirmPassword){
    errorText='Tài khoản đã tồn tại !';
    notifyListeners();
    return false;
    }
    else if(password!=''&&confirmPassword!=''&&password!=confirmPassword){
    errorText='Mật khẩu không khớp!';
    notifyListeners();
    return false;
    }
    else{
      // TODO: call use case
      print("Signing up with: $username");
      notifyListeners();
      return true;
    }
  }
}

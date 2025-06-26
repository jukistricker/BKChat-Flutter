class LoginRequest {
  String username;
  String password;

  LoginRequest({
    this.username = '',
    this.password = '',

  });

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Password': password,
    };
  }

  bool isValid() {
    return username.isNotEmpty &&
        password.isNotEmpty;
  }
}

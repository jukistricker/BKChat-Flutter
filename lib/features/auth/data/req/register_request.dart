class RegisterRequest {
  String displayName;
  String username;
  String password;
  String confirmPassword;

  RegisterRequest({
    this.displayName = '',
    this.username = '',
    this.password = '',
    this.confirmPassword = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'FullName':displayName,
      'Password': password,
    };
  }

  bool isValid() {
    return username.isNotEmpty &&
        displayName.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }

  bool isPasswordConfirmed() {
    return password == confirmPassword;
  }
}

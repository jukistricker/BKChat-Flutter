class RegisterRequest {
  String displayName;
  String email;
  String username;
  String password;
  String confirmPassword;

  RegisterRequest({
    this.displayName = '',
    this.email = '',
    this.username = '',
    this.password = '',
    this.confirmPassword = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Email': email,
      'Password': password,
    };
  }

  bool isValid() {
    return username.isNotEmpty &&
        email.isNotEmpty &&
        displayName.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }

  bool isPasswordConfirmed() {
    return password == confirmPassword;
  }
}

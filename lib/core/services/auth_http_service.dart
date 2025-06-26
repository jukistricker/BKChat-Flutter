import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/features/auth/presentation/pages/login_page.dart';
import 'package:untitled/main.dart'; // để dùng navigatorKey

class AuthHttpService {
  static const _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  static Future<Map<String, String>> _getAuthHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      await prefs.clear();

      // Chuyển về LoginPage
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );

      // ✅ Hiện dialog lỗi nhẹ nhàng
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Thông báo"),
            content: const Text("Có lỗi xảy ra. Vui lòng thử lại sau."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

      // Không cần header → req sẽ fail
      return {};
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }


  static Future<http.Response> getAuth(String url) async {
    final headers = await _getAuthHeaders();
    return http.get(Uri.parse(url), headers: headers);
  }

  static Future<http.Response> postAuth(String url, Map<String, dynamic> body) async {
    final headers = await _getAuthHeaders();
    return http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> putAuth(String url, Map<String, dynamic> body) async {
    final headers = await _getAuthHeaders();
    return http.put(Uri.parse(url), headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> deleteAuth(String url) async {
    final headers = await _getAuthHeaders();
    return http.delete(Uri.parse(url), headers: headers);
  }

  static Future<http.Response> post(String url, Map<String, dynamic> body) async {
    return http.post(Uri.parse(url),headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
  }


  static void logCurlRequestAuth(String url, Map<String, String> headers, Map<String, dynamic> body) {
    final buffer = StringBuffer();

    buffer.write('curl -X POST "$url" \\\n');

    headers.forEach((key, value) {
      buffer.write('  -H "$key: $value" \\\n');
    });

    final jsonBody = jsonEncode(body).replaceAll('"', '\\"');
    buffer.write('  -d "$jsonBody"');

    print('=== CURL REQUEST ===');
    print(buffer.toString());
    print('====================');
  }

  static void logCurlRequest(String url, Map<String, dynamic> body) {
    final buffer = StringBuffer();

    buffer.write('curl -X POST "$url" \\\n');

    final jsonBody = jsonEncode(body).replaceAll('"', '\\"');
    buffer.write('  -d "$jsonBody"');

    print('=== CURL REQUEST ===');
    print(buffer.toString());
    print('====================');
  }
}




import 'dart:convert';


import 'package:untitled/core/config/app.config.dart';

import 'auth_http_service.dart';

class FriendService {
  static Future<List<Map<String, dynamic>>> fetchFriends() async {

    final res = await AuthHttpService.getAuth(ApiConfig.listFrUrl);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data['status'] == 1) {
        return List<Map<String, dynamic>>.from(data['data']);
      }
    }
    return [];
  }
}

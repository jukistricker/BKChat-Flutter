import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig{
  static final baseUrl = dotenv.env['BASE_URL']!;

  //ping
  static final pingUrl = '$baseUrl/ping';
  static final checkUrl = '$baseUrl/check';

  //auth
  static final authUrl = '$baseUrl/auth';

  static final loginUrl = '$authUrl/login';
  static final regUrl = '$authUrl/register';

  //user
  static final userUrl = '$baseUrl/user';

  //message
  static final msgUrl = '$baseUrl/message';

  static final listFrUrl = '$msgUrl/list-friend';


}
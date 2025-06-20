import 'package:realm/realm.dart';

part 'user.realm.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late String id;

  late String username;
  late String fullName;
  late String? avatarPath; // đường dẫn local ảnh
  late String? token;

  late DateTime lastLoginAt;
}

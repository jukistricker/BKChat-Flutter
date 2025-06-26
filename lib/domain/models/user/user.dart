import 'package:realm/realm.dart';

part 'user.realm.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late ObjectId id;

  late String userId;

  late String username;
  late String fullName;
  late String? avatarPath; // đường dẫn local ảnh

  late DateTime lastLoginAt;
}

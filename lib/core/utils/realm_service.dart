import 'package:realm/realm.dart';
import 'package:untitled/domain/models/user/user.dart';

class RealmService {
  static final RealmService _instance = RealmService._internal();
  late final Realm realm;

  factory RealmService() {
    return _instance;
  }

  RealmService._internal() {
    final config = Configuration.local([
      User.schema,

    ]);
    realm = Realm(config);
  }
}

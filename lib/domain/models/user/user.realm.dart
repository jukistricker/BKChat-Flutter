// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  User(
    String id,
    String username,
    String fullName,
    DateTime lastLoginAt, {
    String? avatarPath,
    String? token,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'username', username);
    RealmObjectBase.set(this, 'fullName', fullName);
    RealmObjectBase.set(this, 'avatarPath', avatarPath);
    RealmObjectBase.set(this, 'token', token);
    RealmObjectBase.set(this, 'lastLoginAt', lastLoginAt);
  }

  User._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get username =>
      RealmObjectBase.get<String>(this, 'username') as String;
  @override
  set username(String value) => RealmObjectBase.set(this, 'username', value);

  @override
  String get fullName =>
      RealmObjectBase.get<String>(this, 'fullName') as String;
  @override
  set fullName(String value) => RealmObjectBase.set(this, 'fullName', value);

  @override
  String? get avatarPath =>
      RealmObjectBase.get<String>(this, 'avatarPath') as String?;
  @override
  set avatarPath(String? value) =>
      RealmObjectBase.set(this, 'avatarPath', value);

  @override
  String? get token => RealmObjectBase.get<String>(this, 'token') as String?;
  @override
  set token(String? value) => RealmObjectBase.set(this, 'token', value);

  @override
  DateTime get lastLoginAt =>
      RealmObjectBase.get<DateTime>(this, 'lastLoginAt') as DateTime;
  @override
  set lastLoginAt(DateTime value) =>
      RealmObjectBase.set(this, 'lastLoginAt', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  Stream<RealmObjectChanges<User>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<User>(this, keyPaths);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'username': username.toEJson(),
      'fullName': fullName.toEJson(),
      'avatarPath': avatarPath.toEJson(),
      'token': token.toEJson(),
      'lastLoginAt': lastLoginAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(User value) => value.toEJson();
  static User _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'username': EJsonValue username,
        'fullName': EJsonValue fullName,
        'lastLoginAt': EJsonValue lastLoginAt,
      } =>
        User(
          fromEJson(id),
          fromEJson(username),
          fromEJson(fullName),
          fromEJson(lastLoginAt),
          avatarPath: fromEJson(ejson['avatarPath']),
          token: fromEJson(ejson['token']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(User._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('username', RealmPropertyType.string),
      SchemaProperty('fullName', RealmPropertyType.string),
      SchemaProperty('avatarPath', RealmPropertyType.string, optional: true),
      SchemaProperty('token', RealmPropertyType.string, optional: true),
      SchemaProperty('lastLoginAt', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

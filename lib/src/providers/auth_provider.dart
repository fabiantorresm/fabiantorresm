import 'dart:async';
import 'dart:convert';

import 'package:fabiantorresm/src/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class AuthProvider {
  AuthProvider._internal();
  static AuthProvider _instance = AuthProvider._internal();
  static AuthProvider get instance => _instance;

  final _storage = FlutterSecureStorage();
  final key = "SESSION";

  Completer _completer;

  Future<String> get accessToken async {
    if (_completer != null) {
      await _completer.future;
    }
    print("accessToken");
    _completer = Completer();

    final Session session = await this.getSession();
    if (session != null) {
      return session.token;
    }
    _complete();
    print("session null");
    return null;
  }

  _complete() {
    if (this._completer != null && !this._completer.isCompleted) {
      this._completer.complete();
    }
  }

  Future<void> setSession(
      {@required String token,
      @required String client,
      @required String uid,
      @required int expiry}) async {
    final Session session = Session(
      token: token,
      client: client,
      uid: uid,
      expiry: expiry,
      createdAt: DateTime.now(),
    );
    final String value = jsonEncode(session.toJson());
    print(session.toJson());
    print(value);
    await this._storage.write(key: key, value: value);

    print("session saved");
  }

  Future<Session> getSession() async {
    final String value = await this._storage.read(key: key);
    if (value != null) {
      final Map<String, dynamic> json = jsonDecode(value);
      final session = Session.fromJson(json);
      print('OBTENIENDO LA SESSION_01: => ${session.token}');
      return session;
    }
    return null;
  }

  Future<void> deleteAll() async {
    await this._storage.deleteAll();
  }
}

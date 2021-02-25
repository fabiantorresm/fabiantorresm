import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:fabiantorresm/src/providers/shared_preference_user.dart';
import 'package:fabiantorresm/src/providers/providers.dart';
import 'package:fabiantorresm/src/models/models.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// const baseUrl = 'http://192.168.15.100:3000/auth/sign_in';

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final SharedPreferenceUser sharedPreferenceUser = SharedPreferenceUser();

  Stream<AuthenticationStatus> get status async* {
    final Session session = await AuthProvider.instance.getSession();
    if (session != null) {
      yield AuthenticationStatus.authenticated;
      yield* _controller.stream;
    } else {
      _controller.add(AuthenticationStatus.authenticated);
      yield AuthenticationStatus.unauthenticated;
      yield* _controller.stream;
    }
  }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);
    try {
      var client = http.Client();
      try {
        var response = await client.post(
            "https://rails-web-api.herokuapp.com/api/auth/sign_in/",
            body: {'email': email, 'password': password});
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.headers;
          await AuthProvider.instance.setSession(
              token: data['access-token'],
              client: data['client'],
              uid: data['uid'],
              expiry: int.parse(data['expiry']));
          _controller.add(AuthenticationStatus.authenticated);
        } else {
          print(response.statusCode);
          print(response.headers);
        }
      } finally {
        client.close();
      }
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  void getHttp() async {
    try {
      Response response = await Dio().get("http://192.168.15.100:3000");
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print(response.statusMessage);
      } else {
        print('NO HAY CONEXIÓN CON EL SERVIDOR');
      }
    } catch (e) {
      print(e);
    }
  }

  void logOut() async {
    await AuthProvider.instance.deleteAll();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new SharedPreferenceUser();
    prefs.initPrefs();

*/

class SharedPreferenceUser {
  static final SharedPreferenceUser _instance =
      new SharedPreferenceUser._internal();

  factory SharedPreferenceUser() {
    return _instance;
  }

  SharedPreferenceUser._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  Future<bool> deleteShared() async {
    return await this._prefs.clear();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fabiantorresm/src/providers/shared_preference_user.dart';

part 'sharedpreference_state.dart';

class SharedpreferenceCubit extends Cubit<SharedpreferenceState> {
  final SharedPreferenceUser _sharedPreferenceUser;
  SharedpreferenceCubit(this._sharedPreferenceUser)
      : super(SharedpreferenceInitial());

  Future<void> getToken() async {
    try {
      emit(SharedpreferenceInitial());
      await _sharedPreferenceUser.initPrefs();
      final token = _sharedPreferenceUser.token;
      if (token != null) {
        emit(SharedpreferenceLoaded(token));
      } else {
        emit(SharedpreferenceError('HUbo un error al obtener el token'));
      }
    } catch (e) {
      emit(SharedpreferenceError(e));
    }
  }

  Future<void> setToken(String token) async {
    await _sharedPreferenceUser.initPrefs();
    _sharedPreferenceUser.token = token;
    emit(SharedpreferenceLoaded(token));
  }
}

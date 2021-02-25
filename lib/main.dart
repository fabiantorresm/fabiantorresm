import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:fabiantorresm/app.dart';
import 'package:fabiantorresm/simple_bloc_observer.dart';
import 'package:fabiantorresm/src/logic/logic.dart';
import 'package:fabiantorresm/src/providers/shared_preference_user.dart';
import 'src/repositories/repositories.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final SharedPreferenceUser sharedPreferenceUser = SharedPreferenceUser();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider<SharedpreferenceCubit>(
            create: (_) =>
                SharedpreferenceCubit(sharedPreferenceUser)..getToken()),
        BlocProvider<PostBloc>(
            create: (_) =>
                PostBloc(httpClient: http.Client())..add(PostFetched())),
        BlocProvider<CustomerBloc>(
            create: (_) => CustomerBloc(httpClient: http.Client())
              ..add(CustomersFetched())),
      ],
      child: App(
        authenticationRepository: AuthenticationRepository(),
      ),
    ));
  });
}

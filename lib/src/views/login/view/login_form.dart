import 'package:dio/dio.dart';
import 'package:fabiantorresm/src/logic/logic.dart';
import 'package:fabiantorresm/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: Container(
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo-inprodi.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(child: _EmailInput(), padding: EdgeInsets.all(12)),
              Padding(child: _PasswordInput(), padding: EdgeInsets.all(12)),
              Padding(
                padding: const EdgeInsets.all(12),
                child: _LoginButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void getHttp(BuildContext context) async {
  try {
    Response response = await Dio().get("http://192.168.15.100:3000");
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print(response.statusMessage);
      final snackbar = SnackBar(content: Text('${response.statusCode}'));
      Scaffold.of(context).showSnackBar(snackbar);
    } else {
      print('NO HAY CONEXIÓN CON EL SERVIDOR');
    }
  } catch (e) {
    print(e);
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          // controller: myControllerEmail,
          keyboardType: TextInputType.emailAddress,
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginEmailChanged(username)),
          decoration: InputDecoration(
            prefixIcon:
                Icon(FontAwesomeIcons.envelope, color: primaryDarkColor),
            labelText: 'Correo',
            errorText:
                state.email.invalid ? 'El campo no puede estar vacío' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          // controller: myControllerPassword,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.key, color: primaryDarkColor),
            labelText: 'Contraseña',
            errorText: state.password.invalid ? 'Contraseña inválida' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: Text(
                  'Login'.toUpperCase(),
                  style: TextStyle(fontSize: 18, letterSpacing: 2),
                ),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

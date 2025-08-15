import 'package:asmart_linphone/routing/app_router.dart';
import 'package:asmart_linphone/utils/linphone_util.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation.dart';

import 'bloc/login_screen_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginScreenBloc(),
      child: _LoginScreenView(),
    );
  }
}

class _LoginScreenView extends StatelessWidget {
  final _textLoginController = TextEditingController();
  final _textPasswordController = TextEditingController();
  final _textSIPController = TextEditingController();
  final _loginScreenBloc = LoginScreenBloc();
  final _linphoneUtils = LinphoneUtil();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            child: BlocListener(
              bloc: _loginScreenBloc,
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  _linphoneUtils.requestPermissions();
                  MainRoute().push(context);
                }
              },
              child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
                bloc: _loginScreenBloc,
                builder: (context, state) {
                  if (state is LoginScreenInitial) {
                    _loginScreenBloc.add(CheckSavedDetailsEvent());
                  }
                  return state is LoginInState
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: EdgeInsets.all(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _textLoginController,
                                validator: (value) {
                                  final validator = Validator(
                                    validators: [
                                      const RequiredValidator(),
                                      const MinLengthValidator(length: 3),
                                    ],
                                  );
                                  return validator.validate(
                                    label:
                                        "Логин состоит минимум из 3х символов",
                                    value: value,
                                  );
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Логин',
                                  labelText: 'Логин',
                                ),
                              ),
                              TextFormField(
                                controller: _textPasswordController,
                                obscureText: true,
                                validator: (value) {
                                  final validator = Validator(
                                    validators: [
                                      const RequiredValidator(),
                                      const MinLengthValidator(length: 3),
                                    ],
                                  );
                                  return validator.validate(
                                    label:
                                        "Пароль состоит минимум из 3х символов",
                                    value: value,
                                  );
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.password),
                                  hintText: 'Пароль',
                                  labelText: 'Пароль',
                                ),
                              ),
                              TextFormField(
                                controller: _textSIPController,
                                validator: (value) {
                                  final validator = Validator(
                                    validators: [
                                      const RequiredValidator(),
                                      const MinLengthValidator(length: 3),
                                    ],
                                  );
                                  return validator.validate(
                                    label:
                                        "Домен состоит минимум из 3х символов",
                                    value: value,
                                  );
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.sip),
                                  hintText: 'sip.domain.com',
                                  labelText: 'SIP домен',
                                ),
                              ),
                              SizedBox(height: 5),
                              Column(
                                children: [
                                  state is LoginFailedState
                                      ? Text(
                                          "Авторизация неуспешна. Проверьте данные.",
                                        )
                                      : Container(),
                                  ElevatedButton(
                                    onPressed: () => {
                                      if (Form.of(context).validate())
                                        {
                                          _loginScreenBloc.add(
                                            LoginEvent(
                                              username:
                                                  _textLoginController.text,
                                              password:
                                                  _textPasswordController.text,
                                              domain: _textSIPController.text,
                                            ),
                                          ),
                                        },
                                    },
                                    child: Text('Войти'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

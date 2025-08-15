import 'package:asmart_linphone/utils/secure_storage_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';
import 'package:linphone_flutter_plugin/login_state.dart';

part 'login_screen_event.dart';

part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final _linphoneSdkPlugin = LinphoneFlutterPlugin();

  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginInState());
      try {
        await _linphoneSdkPlugin.login(
          userName: event.username,
          password: event.password,
          domain: event.domain,
        );

        await emit.forEach(
          _linphoneSdkPlugin.addLoginListener(),
          onData: (loginState) {
            if (loginState == LoginState.ok) {
              SecureStorageUtils().saveSipSettings(
                domain: event.domain,
                username: event.username,
                password: event.password,
              );
              return LoginSuccessState();
            } else if (loginState == LoginState.failed) {
              return LoginFailedState();
            }
            return LoginInState();
          },
        );
      } catch (e) {
        print("Something went wrong while login. Error: ${e.toString()}");
        emit(LoginFailedState());
      }
    });

    on<CheckSavedDetailsEvent>((event, emit) async {
      final sipSettings = await SecureStorageUtils().getSipSettings();
      if ((sipSettings["username"] ?? '') != '') {
        add(
          LoginEvent(
            username: sipSettings['username'] ?? '',
            password: sipSettings['password'] ?? '',
            domain: sipSettings['domain'] ?? '',
          ),
        );
      }
    });
  }
}

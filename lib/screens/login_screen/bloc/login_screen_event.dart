part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent {}

class CheckSavedDetailsEvent extends LoginScreenEvent {}

class LoginEvent extends LoginScreenEvent {
  final String username;
  final String password;
  final String domain;
  LoginEvent({required this.username, required this.password, required this.domain});

}

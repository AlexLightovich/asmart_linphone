part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenState {}

final class LoginScreenInitial extends LoginScreenState {}
final class CallActiveState extends LoginScreenState {}
final class NoCallActiveState extends LoginScreenState {}

final class LoginInState extends LoginScreenState {}
final class LoginProgressState extends LoginScreenState {}
final class LoginSuccessState extends LoginScreenState {}
final class LoginFailedState extends LoginScreenState {}

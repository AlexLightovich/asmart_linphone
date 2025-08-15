part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}
final class IdleState extends MainScreenState {}
final class CallReleasedState extends MainScreenState {}
final class CallAcceptedState extends MainScreenState {}
final class OutgoingCallErrorState extends MainScreenState {}
final class IncomingCallState extends MainScreenState {

  final String number;

  IncomingCallState({required this.number});

}

final class OutgoingCallState extends MainScreenState {

  final String number;

  OutgoingCallState({required this.number});

}
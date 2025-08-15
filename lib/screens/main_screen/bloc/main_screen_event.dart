part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenEvent {}
class MainScreenInitialEvent extends MainScreenEvent {}
class CallAcceptedEvent extends MainScreenEvent {}
class MakeOutgoingCallEvent extends MainScreenEvent {
  final String number;

  MakeOutgoingCallEvent({required this.number});
}

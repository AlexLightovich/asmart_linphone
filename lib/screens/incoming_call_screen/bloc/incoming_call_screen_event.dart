part of 'incoming_call_screen_bloc.dart';

@immutable
sealed class IncomingCallScreenEvent {}

class ToggleMicEvent extends IncomingCallScreenEvent {}

class ToggleSpeakerEvent extends IncomingCallScreenEvent {}

class StartCallTimerEvent extends IncomingCallScreenEvent {}
class IncomingCallAcceptedEvent extends IncomingCallScreenEvent {}
class IncomingCallHangUpEvent extends IncomingCallScreenEvent {}

class CheckActiveCallEvent extends IncomingCallScreenEvent {
  final CallState lastCallState;
  CheckActiveCallEvent({required this.lastCallState});
}
class IdleCallEvent extends IncomingCallScreenEvent {}

class _TickEvent extends IncomingCallScreenEvent {}

part of 'outgoing_call_screen_bloc.dart';

@immutable
sealed class OutgoingCallScreenEvent {}
class IdleCallEvent extends OutgoingCallScreenEvent {}


class OutgoingCallAcceptedEvent extends OutgoingCallScreenEvent {}
class OutgoingCallHangUpEvent extends OutgoingCallScreenEvent {}

class ToggleMicEvent extends OutgoingCallScreenEvent {}

class ToggleSpeakerEvent extends OutgoingCallScreenEvent {}

class StartCallTimerEvent extends OutgoingCallScreenEvent {}

class _TickEvent extends OutgoingCallScreenEvent {}
class CheckActiveCallEvent extends OutgoingCallScreenEvent {
  final CallState lastCallState;
  CheckActiveCallEvent({required this.lastCallState});
}


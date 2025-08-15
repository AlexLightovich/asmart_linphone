part of 'incoming_call_screen_bloc.dart';

@immutable
class IncomingCallScreenState {}

final class IncomingCallScreenInitial extends IncomingCallScreenState {}
class IncomingCallReleasedState extends IncomingCallScreenState {}
class IncomingCallIdleState extends IncomingCallScreenState {}

final class IncomingCallStatusesState extends IncomingCallScreenState {
  final bool isMicEnabled;
  final bool isSpeakerEnabled;
  final Duration callDuration;

  IncomingCallStatusesState({
    required this.isMicEnabled,
    required this.isSpeakerEnabled,
    required this.callDuration,
  });

  IncomingCallStatusesState copyWith({
    bool? isMicEnabled,
    bool? isSpeakerEnabled,
    Duration? callDuration,
  }) {
    return IncomingCallStatusesState(
      isMicEnabled: isMicEnabled ?? this.isMicEnabled,
      isSpeakerEnabled: isSpeakerEnabled ?? this.isSpeakerEnabled,
      callDuration: callDuration ?? this.callDuration,
    );
  }
}

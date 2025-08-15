part of 'outgoing_call_screen_bloc.dart';

@immutable
sealed class OutgoingCallScreenState {}

final class OutgoingCallScreenInitial extends OutgoingCallScreenState {}
class OutgoingCallReleasedState extends OutgoingCallScreenState {}
class OutgoingCallIdleState extends OutgoingCallScreenState {}

final class OutgoingCallStatusesState extends OutgoingCallScreenState {
  final bool isMicEnabled;
  final bool isSpeakerEnabled;
  final Duration callDuration;

  OutgoingCallStatusesState({
    required this.isMicEnabled,
    required this.isSpeakerEnabled,
    required this.callDuration,
  });

  OutgoingCallStatusesState copyWith({
    bool? isMicEnabled,
    bool? isSpeakerEnabled,
    Duration? callDuration,
  }) {
    return OutgoingCallStatusesState(
      isMicEnabled: isMicEnabled ?? this.isMicEnabled,
      isSpeakerEnabled: isSpeakerEnabled ?? this.isSpeakerEnabled,
      callDuration: callDuration ?? this.callDuration,
    );
  }
}

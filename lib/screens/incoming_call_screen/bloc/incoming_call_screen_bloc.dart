import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:linphone_flutter_plugin/call_state.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';
import 'package:meta/meta.dart';

part 'incoming_call_screen_event.dart';

part 'incoming_call_screen_state.dart';

class IncomingCallScreenBloc
    extends Bloc<IncomingCallScreenEvent, IncomingCallScreenState> {
  Duration _duration = Duration.zero;

  IncomingCallScreenBloc() : super(IncomingCallIdleState()) {
    Timer? callTimer;
    IncomingCallStatusesState buildStatusState() {
      final currentState = state as IncomingCallStatusesState;
      return currentState.copyWith(callDuration: _duration);
    }

    on<ToggleMicEvent>((event, emit) {
      final linphoneSdkPlugin = LinphoneFlutterPlugin();
      linphoneSdkPlugin.toggleMute();
      var statuses = state as IncomingCallStatusesState;
      emit(statuses.copyWith(isMicEnabled: !statuses.isMicEnabled));
    });

    on<ToggleSpeakerEvent>((event, emit) {
      final linphoneSdkPlugin = LinphoneFlutterPlugin();
      linphoneSdkPlugin.toggleSpeaker();
      var statuses = state as IncomingCallStatusesState;
      emit(statuses.copyWith(isSpeakerEnabled: !statuses.isSpeakerEnabled));
    });

    on<StartCallTimerEvent>((event, emit) {
      callTimer?.cancel();
      callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(_TickEvent());
      });
    });

    on<CheckActiveCallEvent>((event, emit) async {
      if (event.lastCallState == CallState.released) {
        emit(IncomingCallReleasedState());
      }
    });

    on<IncomingCallAcceptedEvent>((event, emit) async {
      emit(
        IncomingCallStatusesState(
          isMicEnabled: true,
          isSpeakerEnabled: false,
          callDuration: Duration.zero,
        ),
      );
    });

    on<_TickEvent>((event, emit) {
      _duration += const Duration(seconds: 1);
      emit(buildStatusState());
    });

    on<IdleCallEvent>((event, emit) {
      emit(IncomingCallIdleState());
    });

    on<IncomingCallHangUpEvent>((event, emit) {
      callTimer?.cancel();
      emit(IncomingCallReleasedState());
    });
  }
}

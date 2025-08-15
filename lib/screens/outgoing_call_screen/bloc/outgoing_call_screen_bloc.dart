import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:linphone_flutter_plugin/call_state.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';

part 'outgoing_call_screen_event.dart';

part 'outgoing_call_screen_state.dart';

class OutgoingCallScreenBloc
    extends Bloc<OutgoingCallScreenEvent, OutgoingCallScreenState> {
  OutgoingCallScreenBloc() : super(OutgoingCallScreenInitial()) {

    Duration duration = Duration.zero;
    Timer? callTimer;

    OutgoingCallStatusesState buildStatusState() {
      final currentState = state as OutgoingCallStatusesState;
      return currentState.copyWith(callDuration: duration);
    }

    on<ToggleMicEvent>((event, emit) {
      final linphoneSdkPlugin = LinphoneFlutterPlugin();
      linphoneSdkPlugin.toggleMute();
      var statuses = state as OutgoingCallStatusesState;
      emit(statuses.copyWith(isMicEnabled: !statuses.isMicEnabled));
    });

    on<ToggleSpeakerEvent>((event, emit) {
      final linphoneSdkPlugin = LinphoneFlutterPlugin();
      linphoneSdkPlugin.toggleSpeaker();
      var statuses = state as OutgoingCallStatusesState;
      emit(statuses.copyWith(isSpeakerEnabled: !statuses.isSpeakerEnabled));
    });

    on<StartCallTimerEvent>((event, emit) {
      callTimer?.cancel();
      callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(_TickEvent());
      });
    });

    on<OutgoingCallAcceptedEvent>((event, emit) async {
      emit(OutgoingCallStatusesState(isMicEnabled: true, isSpeakerEnabled: false, callDuration: Duration.zero),);
    });

    on<CheckActiveCallEvent>((event, emit) async {
      if (event.lastCallState == CallState.released) {
        emit(OutgoingCallReleasedState());
      }
    });

    on<IdleCallEvent>((event, emit) {
      emit(OutgoingCallIdleState());
    });

    on<OutgoingCallHangUpEvent>((event, emit) {
      callTimer?.cancel();
      emit(OutgoingCallReleasedState());
    });

    on<_TickEvent>((event, emit) {
      duration += const Duration(seconds: 1);
      emit(buildStatusState());
    });
  }
}

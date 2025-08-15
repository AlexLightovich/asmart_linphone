import 'package:asmart_linphone/screens/call_log_screen/call_log_screen.dart';
import 'package:asmart_linphone/utils/app_lifecycle_tracker.dart';
import 'package:asmart_linphone/utils/notification_util.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:linphone_flutter_plugin/call_state.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';

part 'main_screen_event.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final _linphoneSdkPlugin = LinphoneFlutterPlugin();
  var lastCallState = CallState.idle;
  var isError = false;
  MainScreenBloc() : super(MainScreenInitial()) {
    on<MainScreenInitialEvent>((event, emit) async {
      final transformedStream = _linphoneSdkPlugin
          .addCallStateListener()
          .asyncMap((callState) async {
            lastCallState = callState;
            if (callState == CallState.IncomingReceived) {
              String callNum = "No number";
              try {
                var list = await CallLogScreen().callLogs();
                if (list.isNotEmpty) {
                  callNum = list.first.number;
                }
              } catch (e) {
                print("Ошибка при получении callLogs: $e");
              }
              FlutterCallkitIncoming.onEvent.listen((event) async {
                final eventName = event!.event;
                switch (eventName) {
                  case Event.actionCallDecline:
                    _linphoneSdkPlugin.rejectCall();
                    FlutterCallkitIncoming.endAllCalls();
                    break;
                  default:
                    print('Other event: $eventName');
                }
              });
              if(!AppLifecycleTracker().isInForeground) {
                NotificationsUtil().showIncomingCall(
                  uuid: "random",
                  callerName: callNum,
                  callerNumber: callNum,
                );
              }
              return IncomingCallState(number: callNum);
            }
            if (callState == CallState.released) {
              FlutterCallkitIncoming.endAllCalls();
              return CallReleasedState();
            }
            if (callState == CallState.callAnswered) {
              return CallAcceptedState();
            }

            if (callState == CallState.streamsRunning) {
              lastCallState = callState;
              return CallAcceptedState();
            }

            if (callState == CallState.error) {
              isError = true;
              return OutgoingCallErrorState();
            }

            return IdleState();
          });

      await emit.forEach<MainScreenState>(
        transformedStream,
        onData: (state) => state,
      );
    });

    on<MakeOutgoingCallEvent>((event, emit) {
      _linphoneSdkPlugin.call(number: event.number);
      emit(OutgoingCallState(number: event.number));
    });
  }



  void listenCallEvents() {

  }
}

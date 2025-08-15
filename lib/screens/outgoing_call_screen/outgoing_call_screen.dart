import 'package:asmart_linphone/screens/main_screen/bloc/main_screen_bloc.dart';
import 'package:asmart_linphone/screens/outgoing_call_screen/bloc/outgoing_call_screen_bloc.dart';
import 'package:asmart_linphone/utils/app_lifecycle_tracker.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';

import '../../routing/app_router.dart';

@RoutePage()
class OutgoingCallScreen extends StatelessWidget {
  final String number;

  const OutgoingCallScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OutgoingCallScreenBloc(),
      child: _OutgoingCallScreen(number: number),
    );
  }
}

class _OutgoingCallScreen extends StatelessWidget {
  final String number;

  const _OutgoingCallScreen({required this.number});

  @override
  Widget build(BuildContext context) {
    final linphoneSdkPlugin = LinphoneFlutterPlugin();
    final mainScreenBloc = context.read<MainScreenBloc>();
    final outgoingScreenBloc = context.read<OutgoingCallScreenBloc>();
    final forwardCallTextController = TextEditingController();

    AppLifecycleTracker().setOnFirstResume(() {
      outgoingScreenBloc.add(
        CheckActiveCallEvent(lastCallState: mainScreenBloc.lastCallState),
      );
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener(
                bloc: mainScreenBloc,
                listener: (context, state) {
                  if (state is CallReleasedState) {
                    if (mainScreenBloc.isError) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Возникла ошибка при вызове."),
                          content: Text(
                            "Возможно, вы позвонили самому себе, или возникла другая ошибка при совершении вызова. Попробуйте еще раз :)",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                mainScreenBloc.isError = false;
                                context.router.push(MainRoute());
                                outgoingScreenBloc.add(
                                  OutgoingCallHangUpEvent(),
                                );
                                outgoingScreenBloc.add(IdleCallEvent());
                              },
                              child: Text("Закрыть"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      context.router.push(MainRoute());
                      outgoingScreenBloc.add(OutgoingCallHangUpEvent());
                      outgoingScreenBloc.add(IdleCallEvent());
                    }
                  }
                  if (state is CallAcceptedState) {
                    context.read<OutgoingCallScreenBloc>().add(
                      StartCallTimerEvent(),
                    );
                    context.read<OutgoingCallScreenBloc>().add(
                      OutgoingCallAcceptedEvent(),
                    );
                  }
                },
              ),
              BlocListener(
                bloc: outgoingScreenBloc,
                listener: (context, state) {
                  if (state is OutgoingCallReleasedState) {
                    context.router.push(MainRoute());
                    outgoingScreenBloc.add(IdleCallEvent());
                  }
                  if (state is OutgoingCallStatusesState) {
                    context.read<OutgoingCallScreenBloc>().add(
                      StartCallTimerEvent(),
                    );
                  }
                },
              ),
            ],
            child: BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Исходящий вызов",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(number, style: TextStyle(fontSize: 30)),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      BlocBuilder<
                        OutgoingCallScreenBloc,
                        OutgoingCallScreenState
                      >(
                        builder: (context, statee) {
                          return state is CallAcceptedState &&
                                  statee is OutgoingCallStatusesState
                              ? Column(
                                  spacing: 20,
                                  children: [
                                    Text(_formatDuration(statee.callDuration)),
                                    Row(
                                      spacing: 20,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FloatingActionButton(
                                          onPressed: () {
                                            context
                                                .read<OutgoingCallScreenBloc>()
                                                .add(ToggleMicEvent());
                                          },
                                          child: statee.isMicEnabled
                                              ? Icon(Icons.mic)
                                              : Icon(Icons.mic_off),
                                        ),
                                        FloatingActionButton(
                                          onPressed: () {
                                            context
                                                .read<OutgoingCallScreenBloc>()
                                                .add(ToggleSpeakerEvent());
                                          },
                                          child: statee.isSpeakerEnabled
                                              ? Icon(Icons.phone_android)
                                              : Icon(Icons.volume_up),
                                        ),
                                        FloatingActionButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  "Переадресовать вызов",
                                                ),
                                                content: Column(
                                                  children: [
                                                    Text(
                                                      "Введите номер, на который хотите переадресовать вызов",
                                                    ),
                                                    TextField(
                                                      controller:
                                                          forwardCallTextController,
                                                      decoration:
                                                          InputDecoration(
                                                            hintText: "Номер",
                                                            labelText: "Номер",
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: Text("Отмена"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      linphoneSdkPlugin
                                                          .callTransfer(
                                                            destination:
                                                                forwardCallTextController
                                                                    .text,
                                                          );
                                                      linphoneSdkPlugin
                                                          .hangUp();
                                                      context.router.push(
                                                        MainRoute(),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Переадресовать",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.phone_forwarded),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 20,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FloatingActionButton.large(
                                          heroTag: "hangup",
                                          onPressed: () {
                                            linphoneSdkPlugin.hangUp();
                                            context
                                                .read<OutgoingCallScreenBloc>()
                                                .add(OutgoingCallHangUpEvent());
                                          },
                                          backgroundColor: Colors.redAccent,
                                          child: Icon(Icons.call_end),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  spacing: 20,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton.large(
                                      heroTag: "hangup",
                                      onPressed: () {
                                        linphoneSdkPlugin.hangUp();
                                        context
                                            .read<OutgoingCallScreenBloc>()
                                            .add(OutgoingCallHangUpEvent());
                                      },
                                      backgroundColor: Colors.redAccent,
                                      child: Icon(Icons.call_end),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ],
                  ),
                );
              },
              bloc: mainScreenBloc,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

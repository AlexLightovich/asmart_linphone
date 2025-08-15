import 'package:asmart_linphone/screens/call_number_screen/widgets/dialpad_widget.dart';
import 'package:asmart_linphone/screens/main_screen/bloc/main_screen_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CallNumberScreen extends StatelessWidget {
  const CallNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainScreenBloc = context.read<MainScreenBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Набор номера'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: DialPadWidget(
          onCall: (number) {
            mainScreenBloc.add(MakeOutgoingCallEvent(number: number));
          },
        ),
      ),
    );
  }
}

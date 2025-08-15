import 'package:asmart_linphone/screens/main_screen/bloc/main_screen_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linphone_flutter_plugin/CallLog.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';

@RoutePage()
class CallLogScreen extends StatelessWidget {
  const CallLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainScreenBloc = context.read<MainScreenBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('История вызовов'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: callLogs(),
        builder: (context, snapshot) {
          final callLogs = snapshot.data ?? [];

          return callLogs.isNotEmpty ? ListView.builder(
            itemCount: callLogs.length,
            itemBuilder: (context, index) {
              final log = callLogs[index];
              final dateOfCall = DateTime.fromMillisecondsSinceEpoch(
                log.date * 1000,
              );
              return ListTile(
                title: log.status == "Missed"
                    ? Text(log.number, style: TextStyle(color: Colors.red))
                    : Text(log.number),
                subtitle: Text(
                  '${log.status == "Missed"
                      ? "Пропущенный"
                      : log.direction == "Incoming"
                      ? "Входящий: ${formatDuration(log.duration)}"
                      : log.status == "Aborted" ? "Прерван" : "Исходящий: ${formatDuration(log.duration)}"}\n${formatDateTime(dateOfCall)}',
                ),
                leading: log.status == "Missed"
                    ? Icon(Icons.call_missed, color: Colors.red)
                    : log.direction == "Incoming"
                    ? Icon(Icons.call_received) : log.status == "Aborted" ? Icon(Icons.phone_disabled)
                    : Icon(Icons.call_made),
                trailing: IconButton(
                  onPressed: () {
                    mainScreenBloc.add(
                      MakeOutgoingCallEvent(number: log.number),
                    );
                  },
                  icon: Icon(Icons.call),
                ),
              );
            },
          ) : Center(child: Text("История вызовов пуста"),);
        },
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final day = twoDigits(dateTime.day);
    final month = twoDigits(dateTime.month);
    final year = dateTime.year;
    final hour = twoDigits(dateTime.hour);
    final minute = twoDigits(dateTime.minute);

    return '$day.$month.$year | $hour:$minute';
  }

  String formatDuration(int totalSeconds) {
    if (totalSeconds < 60) {
      return '$totalSeconds сек.';
    } else {
      final minutes = totalSeconds ~/ 60;
      final seconds = totalSeconds % 60;
      return '$minutes мин $seconds сек';
    }
  }

  Future<List<CallHistory>> callLogs() async {
    final linphoneSdkPlugin = LinphoneFlutterPlugin();
    try {
      CallLogs callLogs = await linphoneSdkPlugin.callLogs();
      return callLogs.callHistory;
    } catch (e) {
      // Show error message if fetching call logs fails
      return List<CallHistory>.empty();
    }
  }
}

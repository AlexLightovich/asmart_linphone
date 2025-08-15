import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsUtil {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  final bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    const initSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIos,
    );

    await notificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'incoming_call_id',
        "Incoming calls",
        channelDescription: "For receiving incoming calls",
        importance: Importance.max,
        priority: Priority.max,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

  Future<void> showIncomingCall({
    required String uuid,
    required String callerName,
    required String callerNumber,
  }) async {
    await FlutterCallkitIncoming.showCallkitIncoming(
      CallKitParams(
        id: uuid,
        nameCaller: callerName,
        handle: "Входящий вызов из Linphone",
        appName: 'AsmartLinphone',
        textAccept: "Принять",
        textDecline: "Отклонить",

      ),
    );
  }
}

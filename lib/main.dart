import 'package:asmart_linphone/routing/app_router.dart';
import 'package:asmart_linphone/ui/theme/theme.dart';
import 'package:asmart_linphone/utils/app_lifecycle_tracker.dart';
import 'package:asmart_linphone/utils/notification_util.dart';
import 'package:flutter/material.dart';

final appRouter = AppRouter();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationsUtil().initNotification();
  AppLifecycleTracker();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      theme: lightTheme,
    );
  }
}
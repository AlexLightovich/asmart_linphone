import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/call_log_screen/call_log_screen.dart';
import '../screens/call_number_screen/call_number_screen.dart';
import '../screens/incoming_call_screen/incoming_call_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/outgoing_call_screen/outgoing_call_screen.dart';
import '../screens/profile_screen/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(page: CallLogRoute.page, initial: true),
        AutoRoute(page: CallNumberRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: LoginRoute.page),
      ],
    ),
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: IncomingCallRoute.page),
    AutoRoute(page: OutgoingCallRoute.page),
  ];
}

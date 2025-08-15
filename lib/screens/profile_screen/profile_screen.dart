import 'package:asmart_linphone/routing/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';

import '../../utils/secure_storage_utils.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<Map<String, String?>>(
            future: SecureStorageUtils().getSipSettings(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(child: Text('Нет данных'));
              }
              final sipSettings = snapshot.data!;
              final String firstLetter = (sipSettings['username'])!
                  .substring(0,1)
                  .toUpperCase();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(
                      firstLetter,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    sipSettings['username'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "sip:${sipSettings['username']}@${sipSettings['domain']}",
                  ),
                  ElevatedButton(
                    onPressed: () {
                      SecureStorageUtils().clearSipSettings();
                      LinphoneFlutterPlugin().hangUp();
                      LinphoneFlutterPlugin().removeCallListener();
                      LinphoneFlutterPlugin().removeLoginListener();
                      context.router.push(LoginRoute());
                    },
                    child: Text("Выйти из аккаунта"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

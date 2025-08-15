import 'package:asmart_linphone/screens/incoming_call_screen/bloc/incoming_call_screen_bloc.dart';
import 'package:asmart_linphone/screens/main_screen/bloc/main_screen_bloc.dart';
import 'package:asmart_linphone/screens/outgoing_call_screen/outgoing_call_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routing/app_router.dart';
import '../incoming_call_screen/incoming_call_screen.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MainScreenBloc()..add(MainScreenInitialEvent()),
        ),
        BlocProvider(create: (_) => IncomingCallScreenBloc()),
      ],
      child: _MainScreenView(),
    );
  }
}

class _MainScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainScreenBloc = context.read<MainScreenBloc>();
    return PopScope(
      canPop: false,
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          return BlocListener(
            bloc: mainScreenBloc,
            listener: (context, state) {
              if (state is OutgoingCallErrorState) {}

              if (state is IncomingCallState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: mainScreenBloc,
                      child: IncomingCallScreen(number: state.number),
                    ),
                  ),
                );
              }

              if (state is OutgoingCallState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: mainScreenBloc,
                      child: OutgoingCallScreen(number: state.number),
                    ),
                  ),
                );
              }
            },
            child: AutoTabsScaffold(
              routes: const [CallLogRoute(), CallNumberRoute(), ProfileRoute()],
              bottomNavigationBuilder: (_, tabsRouter) {
                return BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  items: const [
                    BottomNavigationBarItem(
                      label: 'История',
                      icon: Icon(Icons.history),
                    ),
                    BottomNavigationBarItem(
                      label: 'Звонок',
                      icon: Icon(Icons.phone),
                    ),
                    BottomNavigationBarItem(
                      label: 'Профиль',
                      icon: Icon(Icons.person),
                    ),
                  ],
                );
              },
            ),
          );
        },
        bloc: mainScreenBloc,
      ),
    );
  }
}

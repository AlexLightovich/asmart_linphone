// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CallLogScreen]
class CallLogRoute extends PageRouteInfo<void> {
  const CallLogRoute({List<PageRouteInfo>? children})
    : super(CallLogRoute.name, initialChildren: children);

  static const String name = 'CallLogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CallLogScreen();
    },
  );
}

/// generated route for
/// [CallNumberScreen]
class CallNumberRoute extends PageRouteInfo<void> {
  const CallNumberRoute({List<PageRouteInfo>? children})
    : super(CallNumberRoute.name, initialChildren: children);

  static const String name = 'CallNumberRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CallNumberScreen();
    },
  );
}

/// generated route for
/// [IncomingCallScreen]
class IncomingCallRoute extends PageRouteInfo<IncomingCallRouteArgs> {
  IncomingCallRoute({
    Key? key,
    required String number,
    List<PageRouteInfo>? children,
  }) : super(
         IncomingCallRoute.name,
         args: IncomingCallRouteArgs(key: key, number: number),
         initialChildren: children,
       );

  static const String name = 'IncomingCallRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IncomingCallRouteArgs>();
      return IncomingCallScreen(key: args.key, number: args.number);
    },
  );
}

class IncomingCallRouteArgs {
  const IncomingCallRouteArgs({this.key, required this.number});

  final Key? key;

  final String number;

  @override
  String toString() {
    return 'IncomingCallRouteArgs{key: $key, number: $number}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IncomingCallRouteArgs) return false;
    return key == other.key && number == other.number;
  }

  @override
  int get hashCode => key.hashCode ^ number.hashCode;
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [OutgoingCallScreen]
class OutgoingCallRoute extends PageRouteInfo<OutgoingCallRouteArgs> {
  OutgoingCallRoute({
    Key? key,
    required String number,
    List<PageRouteInfo>? children,
  }) : super(
         OutgoingCallRoute.name,
         args: OutgoingCallRouteArgs(key: key, number: number),
         initialChildren: children,
       );

  static const String name = 'OutgoingCallRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OutgoingCallRouteArgs>();
      return OutgoingCallScreen(key: args.key, number: args.number);
    },
  );
}

class OutgoingCallRouteArgs {
  const OutgoingCallRouteArgs({this.key, required this.number});

  final Key? key;

  final String number;

  @override
  String toString() {
    return 'OutgoingCallRouteArgs{key: $key, number: $number}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OutgoingCallRouteArgs) return false;
    return key == other.key && number == other.number;
  }

  @override
  int get hashCode => key.hashCode ^ number.hashCode;
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

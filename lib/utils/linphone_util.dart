import 'package:linphone_flutter_plugin/CallLog.dart';
import 'package:linphone_flutter_plugin/linphoneflutterplugin.dart';
import 'package:linphone_flutter_plugin/login_state.dart';

class LinphoneUtil {

  final _linphoneSdkPlugin = LinphoneFlutterPlugin();

  Future<void> requestPermissions() async {
    try {
      await _linphoneSdkPlugin.requestPermissions();
    } catch (e) {
      print("Error on request permission. ${e.toString()}");
    }
  }

  Future<LoginState> login({
    required String username,
    required String pass,
    required String domain,
  }) async {
    try {
      await _linphoneSdkPlugin.login(
          userName: username, domain: domain, password: pass);
      Stream<LoginState> addLoginListener = _linphoneSdkPlugin.addLoginListener();
      LoginState loginState = LoginState.none;
      addLoginListener.listen((LoginState event)  {
        loginState = event;
      });
      return loginState;
    } catch (e) {
      print("Error on login. ${e.toString()}");
      return LoginState.failed;
    }
  }

  Future<void> call(number) async {
    if (number.isNotEmpty) {
      try {
        await _linphoneSdkPlugin.call(number: number);
      } catch (e) {
        print("Error on call. ${e.toString()}");
      }
    }
  }

  Future<void> forward(dest) async {
    try {
      await _linphoneSdkPlugin.callTransfer(destination: dest);
    } catch (e) {
      // Show error message if call transfer fails
      print("Error on call transfer. ${e.toString()}");
    }
  }

  // Method to hang up an ongoing call
  Future<void> hangUp() async {
    try {
      await _linphoneSdkPlugin.hangUp();
    } catch (e) {
      // Show error message if hang up fails
     print("error on hangup");
    }
  }

  // Method to toggle the speaker on/off
  Future<void> toggleSpeaker() async {
    try {
      await _linphoneSdkPlugin.toggleSpeaker();
    } catch (e) {
      // Show error message if toggling the speaker fails
      print("Error on toggle speaker. ${e.toString()}");
    }
  }

  // Method to toggle mute on/off
  Future<void> toggleMute() async {
    try {
      bool isMuted = await _linphoneSdkPlugin.toggleMute();
      print('muted');
    } catch (e) {
      // Show error message if toggling mute fails
      print("Error on toggle mute. ${e.toString()}");
    }
  }

  // Method to answer an incoming call
  Future<void> answer() async {
    try {
      await _linphoneSdkPlugin.answercall();
    } catch (e) {
      // Show error message if answering the call fails
      print("Error on answer call. ${e.toString()}");
    }
  }

  // Method to reject an incoming call
  Future<void> reject() async {
    try {
      await _linphoneSdkPlugin.rejectCall();
    } catch (e) {
      // Show error message if rejecting the call fails
      print("Error on reject call. ${e.toString()}");
    }
  }

  // Method to retrieve and print the call logs
  Future<void> callLogs() async {
    try {
      CallLogs callLogs = await _linphoneSdkPlugin.callLogs();
      print("---------call logs length: ${callLogs.callHistory.length}");
    } catch (e) {
      // Show error message if fetching call logs fails
      print("Error on call logs. ${e.toString()}");
    }
  }
}
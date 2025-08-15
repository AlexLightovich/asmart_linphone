import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'call_log_screen_event.dart';
part 'call_log_screen_state.dart';

class CallLogScreenBloc extends Bloc<CallLogScreenEvent, CallLogScreenState> {
  CallLogScreenBloc() : super(CallLogScreenInitial()) {
    on<CallLogScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

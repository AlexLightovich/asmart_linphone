import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'call_number_screen_event.dart';
part 'call_number_screen_state.dart';

class CallNumberScreenBloc extends Bloc<CallNumberScreenEvent, CallNumberScreenState> {
  CallNumberScreenBloc() : super(CallNumberScreenInitial()) {
    on<CallNumberScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

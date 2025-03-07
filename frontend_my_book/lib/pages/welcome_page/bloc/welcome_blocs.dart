import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/welcome_page/bloc/welcome_events.dart';
import 'package:my_book/pages/welcome_page/bloc/welcome_states.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState>{
  WelcomeBloc():super(WelcomeState()){
    on<WelcomeEvent>((event, emit){
      emit(WelcomeState(page:state.page));
    });
  }

}
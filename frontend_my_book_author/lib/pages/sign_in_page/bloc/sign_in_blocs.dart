import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/pages/sign_in_page/bloc/sign_in_events.dart';
import 'package:learn_teacher_bloc/pages/sign_in_page/bloc/sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc(): super(const SignInState()){
    on<UsernameEvent>(_usernameEvent); //handler
    on<PasswordEvent>(_passwordEvent);
  }

  void _usernameEvent(UsernameEvent event, Emitter<SignInState> emit){ // email handler
    emit(state.copyWith(username: event.username));
  }
  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit){ //password handler
    emit(state.copyWith(password: event.password));
  }
}
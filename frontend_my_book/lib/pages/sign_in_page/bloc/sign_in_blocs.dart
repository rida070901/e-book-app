import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/sign_in_page/bloc/sign_in_events.dart';
import 'package:my_book/pages/sign_in_page/bloc/sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc(): super(const SignInState()){
    on<EmailEvent>(_emailEvent); //handler
    on<PasswordEvent>(_passwordEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit){ // email handler
    emit(state.copyWith(email: event.email));
  }
  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit){ //password handler
    emit(state.copyWith(password: event.password));
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/sign_up_page/bloc/sign_up_events.dart';
import 'package:my_book/pages/sign_up_page/bloc/sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpBloc():super(const SignUpState()){
    on<UsernameEvent>(_usernameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<ConfirmPasswordEvent>(_confirmPasswordEvent);
  }

  void _usernameEvent(UsernameEvent event, Emitter<SignUpState> emit){
    //print("${event.username}");
    emit(state.copyWith(username:event.username));
  }
  void _emailEvent(EmailEvent event, Emitter<SignUpState> emit){
   // print("${event.email}");
    emit(state.copyWith(email:event.email));
  }
  void _passwordEvent(PasswordEvent event, Emitter<SignUpState> emit){
    //print("${event.password}");
    emit(state.copyWith(password:event.password));
  }
  void _confirmPasswordEvent(ConfirmPasswordEvent event, Emitter<SignUpState> emit){
    //print("${event.confirmPassword}");
    emit(state.copyWith(confirmPassword:event.confirmPassword));
  }
}
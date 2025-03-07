import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/book_page/checkout_page/bloc/checkout_events.dart';
import 'package:my_book/pages/book_page/checkout_page/bloc/checkout_states.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState>{
  CheckoutBloc():super(const CheckoutState()){
    on<TriggerCheckout>(_triggerCheckout);
  }

  void _triggerCheckout(TriggerCheckout event, Emitter<CheckoutState> emit){
    emit(state.copyWith(url: event.url));
  }

}
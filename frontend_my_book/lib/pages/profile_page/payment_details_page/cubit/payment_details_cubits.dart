import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/profile_page/payment_details_page/cubit/payment_details_states.dart';

import '../../../../common/entities/book.dart';

class PaymentDetailCubits extends Cubit<PaymentDetailStates>{
  PaymentDetailCubits():super(InitialPaymentDetailStates());

  void historyPaymentDetails(List<BookItem> bookItem){
    print('-------------emitting states of history');
    emit(HistoryPaymentDetailStates(bookItem));
  }
  void loadingPaymentDetailStates(){
    print('-------------emitting loading states of history');
    emit(LoadingPaymentDetailStates());
  }
  void doneLoadingPaymentDetailStates(){
    print('-------------emitting done loading states of history');
    emit(DoneLoadingPaymentDetailStates());
  }
}
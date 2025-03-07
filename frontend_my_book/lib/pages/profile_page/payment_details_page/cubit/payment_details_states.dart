import '../../../../common/entities/book.dart';

abstract class PaymentDetailStates{
  const PaymentDetailStates();
}

class InitialPaymentDetailStates extends PaymentDetailStates{
  const InitialPaymentDetailStates();
}

class LoadingPaymentDetailStates extends PaymentDetailStates{
  const LoadingPaymentDetailStates();
}


class DoneLoadingPaymentDetailStates extends PaymentDetailStates{
  const DoneLoadingPaymentDetailStates();
}

class HistoryPaymentDetailStates extends PaymentDetailStates{
  final List<BookItem> bookItem;
  const HistoryPaymentDetailStates(this.bookItem);
}
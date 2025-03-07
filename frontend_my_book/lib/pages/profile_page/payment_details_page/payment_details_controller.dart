import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/apis/book_api.dart';
import 'cubit/payment_details_cubits.dart';

class PaymentDetailsController{
  late BuildContext context;
  PaymentDetailsController({required this.context});


  //after the context is ready this init() method gets called
  void init(){
    asyncLoadOderData();
  }

  asyncLoadOderData() async {

    context.read<PaymentDetailCubits>().loadingPaymentDetailStates();
    var result = await BookAPI.orderList();
    if(result.code==200){
      if(context.mounted){
        //save data to shared storage
        context.read<PaymentDetailCubits>().doneLoadingPaymentDetailStates();

        Future.delayed(const Duration(milliseconds: 10), (){
          print('${DateTime.now()}');
          context.read<PaymentDetailCubits>().historyPaymentDetails(result.data!);

        });
      }
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/profile_page/payment_details_page/payment_details_controller.dart';
import 'package:my_book/pages/profile_page/payment_details_page/payment_details_widgets.dart';

import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import 'cubit/payment_details_cubits.dart';
import 'cubit/payment_details_states.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {

  late PaymentDetailsController _paymentDetailsController;
  @override
  void didChangeDependencies() {
    _paymentDetailsController = PaymentDetailsController(context: context);
    _paymentDetailsController.init();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentDetailCubits, PaymentDetailStates>(
        builder: (context, state) {
          if(state is HistoryPaymentDetailStates){
            return Scaffold(
              appBar: buildAppBar("Payment details"),
              body:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      menuView(),
                      buildOrderListItem(state),
                    ],
                  ),
                ),
              ),
            );
          }else if(state is LoadingPaymentDetailStates){
            return Scaffold(
              appBar: buildAppBar("Payment details"),
              body: const Center(child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.greyBackground,
                    color: AppColors.warmPink,))),
            );
          }else{
            return Scaffold(
              appBar: buildAppBar("Payment details"),
              body: const Center(child: Text("..something went wrong")),
            );
          }
        });
  }
}

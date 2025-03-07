import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/routes/route_names.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/constants.dart';
import '../../../common/widgets/base_text_widget.dart';
import 'cubit/payment_details_states.dart';

Widget menuView(){
  return Container(
    width: 325.w,
    margin: EdgeInsets.only(
      top:15.h,
      bottom: 8.h,
    ),
    child: reusableText(
      "Your e-books payment history",
      fontSize: 14.sp,
    ),
  );
}

Widget buildOrderListItem(HistoryPaymentDetailStates state){
  return SingleChildScrollView(

    child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.bookItem.length,
        itemBuilder: (context, index){

          return Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 325.w,
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 1))
                ]),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.BOOK_DETAILS, arguments: {
                  "id":state.bookItem[index].id
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //for image and the text
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.h),
                            image:  DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage("${state.bookItem[index].thumbnail!}"))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //list item title
                          listItemContainer(state.bookItem[index].name.toString()),
                          //list item description
                          listItemContainer(
                              "${state.bookItem[index].page_num} pages",
                              fontSize: 10,
                              color: AppColors.strongGrey,
                              fontWeight: FontWeight.normal)
                        ],
                      )
                    ],
                  ),

                  //for showing the right arrow
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 55.w,
                        child: Text(
                          "\$${state.bookItem[index].price??""}",
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.blackText,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                      ),
                      Container(
                        width: 55.w,
                        child: Text(
                          state.bookItem[index].status==0?'failed':'success',
                          maxLines: 1,
                          style: TextStyle(
                              color: state.bookItem[index].status==0?Colors.redAccent:Colors.greenAccent,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
  );
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/entities/msgcontent.dart';
import '../../../common/values/colors.dart';

Widget chatFileButton(String iconPath){
  return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(10.w),
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
              color: AppColors.whiteBackground,
              borderRadius: BorderRadius.circular(15.w),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Image.asset(iconPath)
      ));
}

Widget chatRightWidget(Msgcontent item){
  return Container(
      padding: EdgeInsets.only(top: 10.w, bottom: 10.w, right: 0.w, left: 20.w),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 250.w,
            minHeight: 40.w
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 0.w, top: 0.w),
                padding: EdgeInsets.only(top: 10.w, bottom: 10.w, right: 10.w, left: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.warmPink,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0.w),
                    topLeft: Radius.circular(20.w),
                    bottomLeft: Radius.circular(20.w),
                    bottomRight: Radius.circular(20.w)
                  ),

                ),
                child: Text("${item.content}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.lightText
                  )),
              )
            ],
          ),
        )
      ],
    )
  );
}

Widget chatLeftWidget(Msgcontent item){
  return Container(
      padding: EdgeInsets.only(top: 10.w, bottom: 10.w, right: 0.w, left: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 250.w,
                minHeight: 40.w
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 0.w, top: 0.w),
                  padding: EdgeInsets.only(top: 10.w, bottom: 10.w, right: 10.w, left: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.greyBackground,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(0.w),
                        bottomLeft: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w)
                    ),

                  ),
                  child: Text("${item.content}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blackText
                      )),
                )
              ],
            ),
          )
        ],
      )
  );
}
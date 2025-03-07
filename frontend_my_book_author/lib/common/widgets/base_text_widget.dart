
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../values/colors.dart';

AppBar buildAppBar(String text, {FontWeight fontWeight = FontWeight.normal, int fontSize = 16, Color color = Colors.black}) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.greyBackground,
        height: 1.0,  //height defines the thickness of the line
      ),
    ),
    title: Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: fontSize.sp,
            fontWeight: fontWeight),
      ),
  );
}

Widget reusableText(String text,
    {Color color = AppColors.blackText, double fontSize = 16, FontWeight fontWeight = FontWeight.bold}) {
  return Text(text, style: TextStyle(
      color: color, fontWeight: fontWeight, fontSize: fontSize.sp),
  );
}

  Widget listItemContainer(String name,
      {double fontSize = 13,
        Color color = AppColors.blackText,
        fontWeight = FontWeight.bold}) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.only(left: 6.w),
      child: Text(
        name,
        overflow: TextOverflow.clip,
        maxLines: 1,
        style: TextStyle(
            color: color, fontSize: fontSize.sp, fontWeight: FontWeight.bold),
      ),
    );
  }


  Widget reusableButton(String name) {
    return Container(
        padding: EdgeInsets.only(top: 13.h),
        width: 330.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.warmPink,
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(color: AppColors.warmPink),
        ),
        child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.lightText,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            )
        )
    );
  }

Widget appTextField(String hintText, String textType,
    void Function(String value)? func, {int? maxLines=1, TextEditingController? controller, }){
  return TextField(
    controller: controller,
    onChanged: (value) => func!(value),
    keyboardType: TextInputType.multiline,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hintText,
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      hintStyle: const TextStyle(
          color: AppColors.greyText),
    ),
    style: TextStyle(
        color: AppColors.blackText,
        fontFamily: "Avenir",
        fontWeight: FontWeight.normal,
        fontSize: 14.sp),
    autocorrect: false,
    obscureText: textType == "password" ? true : false,
  );
}


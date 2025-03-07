import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/values/colors.dart';
import 'package:my_book/common/widgets/base_text_widget.dart';
import 'package:my_book/pages/sign_in_page/sign_in_controller.dart';

AppBar buildAppBar(String type) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.greyBackground,
        height: 1.0, //height is the thickness of the line
      ),
    ),
    title: Text(
        type,
        style: TextStyle(
            color: AppColors.blackText,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
      ),
  );
}

//We need context for accessing bloc
Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
      padding: EdgeInsets.only(left: 50.w, right: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _reusableIcons("google", context),
          _reusableIcons("apple", context),
          _reusableIcons("facebook", context)
        ],
      ));
}

Widget _reusableIcons(String iconName, BuildContext context) {
  return GestureDetector(
    onTap: () {
      SignInController(context: context).handleSignIn("google");
    },
    child: Container(
      width: 40.w,
      height: 40.w,
      child: Image.asset(
        "assets/icons/$iconName.png",
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget reusableText(String text) {
  return Container(
    margin: EdgeInsets.only(
      bottom: 5.h,
    ),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.grey.withOpacity(0.5),
          fontWeight: FontWeight.normal,
          fontSize: 14.sp),
    ),
  );
}

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func) {
  return Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          border: Border.all(color: AppColors.unselectedGrey)),
      child: Row(
        children: [
          Container(
            width: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            height: 16.w,
            child: Image.asset("assets/icons/$iconName.png"),
          ),
          SizedBox(
            width: 270.w,
            height: 50.h,
            child: appTextField(hintText, textType, func)/*TextField(
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
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
            ), */
          )
        ],
      ));
}

Widget forgotPassword() {
  return Container(
    margin: EdgeInsets.only(left: 25.w),
    width: 260.w,
    height: 44.h,
    child: GestureDetector(
      onTap: () {},
      child: Text(
        "Forgot password",
        style: TextStyle(
            color: AppColors.blackText,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.blackText,
            fontSize: 12.sp),
      ),
    ),
  );
}

Widget buildLogInAdnRegButton(
    String buttonName, String buttonType, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "login" ? 40.h : 20.h),
      decoration: BoxDecoration(
          color: buttonType == "login"
              ? AppColors.warmPink
              : AppColors.whiteBackground,
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(
            //check for registration button border color
              color: buttonType == "login"
                  ? Colors.transparent
                  : AppColors.unselectedGrey),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
                color: Colors.grey.withOpacity(0.1))
          ]),
      child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: buttonType == "login"
                    ? AppColors.whiteBackground
                    : AppColors.blackText),
          )),
    ),
  );
}

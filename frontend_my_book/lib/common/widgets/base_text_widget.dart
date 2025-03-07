
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../pages/home_page/bloc/home_page_blocs.dart';
import '../../pages/home_page/bloc/home_page_events.dart';
import '../../pages/home_page/home_page_controller.dart';
import '../../pages/search_page/search_controller.dart';
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

  Widget searchView(BuildContext context, String hintText, {bool home = true}) {
    return Row(
      children: [
        Container(
          width: 275.w,
          height: 40.h,
          decoration: BoxDecoration(
              color: AppColors.whiteBackground,
              borderRadius: BorderRadius.circular(15.h),
              border: Border.all(color: AppColors.unselectedGrey)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 17.w),
                width: 16.w,
                //height: 16.w,
                child: Image.asset("assets/icons/search.png"),
              ),
              Container(
                width: 240.w,
                height: 40.h,
                child: TextField(
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
                    hintStyle:
                    const TextStyle(color: AppColors.greyText),
                  ),
                  style: TextStyle(
                      color: AppColors.blackText,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp),
                  //when hitting Enter or Return API gets called and returns the search query
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      //we dont make a call from home page
                      if (home == false) {
                        MySearchController(context:context).asyncLoadSearchData(value);
                      }else if(home == true){
                        HomeController(context:context).asyncLoadSearchData(value);
                        context.read<HomePageBloc>().add(const BookListIndex(4));
                      }
                    }
                  },
                  autocorrect: false,
                  obscureText: false,
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 5.w),
        GestureDetector(
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.warmPink,
              borderRadius: BorderRadius.all(Radius.circular(13.w)),
              border: Border.all(color: AppColors.warmPink),
            ),
            alignment: Alignment.center,
              child: SizedBox(
                width: 30.w,
                height: 30.h,
                child: Image.asset("assets/icons/options.png"),
              )
          ),
        )
      ],
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



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/routes/route_names.dart';
import '../../common/values/colors.dart';
import '../../common/values/constants.dart';
import '../../common/widgets/base_text_widget.dart';
import '../../global.dart';
import '../application_start_page/bloc/app_start_page_blocs.dart';
import '../application_start_page/bloc/app_start_page_events.dart';
import '../home_page/bloc/home_page_blocs.dart';
import '../home_page/bloc/home_page_events.dart';
import 'bloc/profile_blocs.dart';
import 'bloc/profile_states.dart';

AppBar buildAppbar(BuildContext context) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 18.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png")),
        Text( "Profile", style: TextStyle(
          color: AppColors.blackText,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        )),
        GestureDetector(
          onTap: () {
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: ()=> Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: (){
                        _removeUserData(context);
                      },
                      child: const Text("Confirm"),
                    ),
                  ]
              );
            });
          },
          child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: Image.asset("assets/icons/more-vertical.png")),
        )
      ],
    ),
  );
}

void _removeUserData(BuildContext context){
  context.read<AppBloc>().add(const TriggerAppEvent(0));
  context.read<HomePageBloc>().add(const HomePageDots(0));
  Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
  Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
}

Widget profileIconAndEditButton(){
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.only(right: 6.w),
    width: 80.w,
    height: 80.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        image: const DecorationImage(
          image: AssetImage("assets/icons/reading.png"),
        )
    ),
    child: Container(
      width: 25.w,
      height: 25.h,
      decoration: BoxDecoration(
          color: AppColors.warmPink,
          borderRadius: BorderRadius.circular(15.w),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/icons/edit.png"))),
    ),
  );
}

var menuRow = <String, String> {
  "Settings" : "settings.png",
  "Payment history" : "credit-card.png",
  "About our app" : "award.png",
  "Favorites" : "heart(1).png",
  "Contact us" : "cube.png",
};

Widget profileColumnMenu(BuildContext context){
  return Column(
    children: [
      ...List.generate(menuRow.length, (index) => GestureDetector(
        onTap: () {
          if(index==0){
            Navigator.of(context).pushNamed(AppRoutes.SETTINGS);
          }
          if(index==1){
          Navigator.of(context).pushNamed(AppRoutes.PAYMENT_DETAILS);
          }
          if(index==2){
            Navigator.of(context).pushNamed(AppRoutes.ABOUT_US);
          }
          if(index==3){
            Navigator.of(context).pushNamed(AppRoutes.FAVORITES);
          }
          if(index==4){
            Navigator.of(context).pushNamed(AppRoutes.CONTACT_US);
          }
        },
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
              child: Row(
                  children: [
                    Container(
                      child: Image.asset("assets/icons/${menuRow.values.elementAt(index)}"),
                      width: 40.w,
                      height: 40.h,
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: AppColors.warmPink,
                      ),
                    ),
                    SizedBox( width: 15.w),
                    Text(
                        menuRow.keys.elementAt(index),
                        style: TextStyle(
                          color: AppColors.blackText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        )
                    )
                  ]
              )
          )
      ),)
    ]
  );
}

Widget profileRowMenu(BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 20.h, bottom: 20.w, left: 25.w, right: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _rowView("heart(1).png", "I love", (){
          Navigator.of(context).pushNamed(AppRoutes.FAVORITES);
        }),
        _rowView("credit-card.png", "My books", (){
          Navigator.of(context).pushNamed(AppRoutes.MY_BOOKS);
        }),
        _rowView("star(2).png", "Orders", (){
          Navigator.of(context).pushNamed(AppRoutes.PAYMENT_DETAILS);
        }),
      ],
    ),
  );
}

Widget _rowView(String image, String name, void Function()? func){
  return GestureDetector(
    onTap: func,
    child: Container(
        padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
        width: 100.w,
        decoration: BoxDecoration(
            color: AppColors.warmPink,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0,3)
              )
            ],
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(color: AppColors.warmPink)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: Image.asset("assets/icons/${image}"),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: reusableText(name,
                  color: AppColors.lightText,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
    ),
  );
}

Widget buildProfileName(ProfileState state){
  return state.userProfile==null ? Container(child: reusableText("no name found"))
      :Container(
        padding: EdgeInsets.only(left: 50.h, right: 50.w),
        margin: EdgeInsets.only(bottom: 10.h, top: 5.w),
        child: Text(state.userProfile?.name??"no name given",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.strongGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal
          ),
        ),
      );
}


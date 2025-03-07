import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/messages_page/chat_list_page/chat_list.dart';
import '../../common/values/colors.dart';
import '../home_page/home_page.dart';
import '../profile_page/my_books_page/my_books.dart';
import '../profile_page/profile.dart';
import '../search_page/search.dart';

Widget buildPage(int index){
  List<Widget> _widget = [
    const HomePage(),
    const Search(),
    const MyBooks(),
    const ChatList(),
    const Profile(),
  ];
  return _widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
    label: "home",
    icon: SizedBox(
      width: 15.w,
      height: 15.h,
      child: Image.asset("assets/icons/home.png"),
    ),
    activeIcon: SizedBox(
      width: 15.w,
      height: 15.h,
      child: Image.asset(
        "assets/icons/home.png",
        color: AppColors.warmPink,
      ),
    ),
  ),
  BottomNavigationBarItem(
    label: "search",
    icon: SizedBox(
      width: 15.w,
      height: 15.h,
      child: Image.asset("assets/icons/search2.png"),
    ),
    activeIcon: SizedBox(
      width: 15.w,
      height: 15.h,
      child: Image.asset(
        "assets/icons/search2.png",
        color: AppColors.warmPink,
      ),
    ),
  ),
  BottomNavigationBarItem(
      label: "course",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/play-circle1.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/play-circle1.png",
          color: AppColors.warmPink,
        ),
      )
  ),
  BottomNavigationBarItem(
      label: "chat",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/message-circle.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/message-circle.png",
          color: AppColors.warmPink,
        ),
      )
  ),
  BottomNavigationBarItem(
      label: "profile",
      icon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset("assets/icons/person2.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/person2.png",
          color: AppColors.warmPink,
        ),
      )
  ),
];
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/application_start_page/bloc/app_start_page_events.dart';
import 'package:my_book/pages/home_page/bloc/home_page_blocs.dart';
import 'package:my_book/pages/home_page/bloc/home_page_events.dart';

import '../../../common/routes/route_names.dart';
import '../../../common/values/constants.dart';
import '../../../global.dart';
import '../../application_start_page/bloc/app_start_page_blocs.dart';

/*AppBar buildAppBar(){
  return AppBar(
    title: Container(
      child: Container(
        child: Text(
          "Settings",
          style: TextStyle(
            color: AppColors.blackText,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          )
        )
      )
    )
  );
} */

String termsAndConditions = " Welcome to My Books App!\nThese terms and conditions outline the rules and regulations for the use of Company Name's Website, located at mybooksapp.com.\nBy accessing this app we assume you accept these terms and conditions. Do not continue to use app if you do not agree to take all of the terms and conditions stated on this page.\n Cookies\n We employ the use of cookies. By accessing Website Name, you agreed to use cookies in agreement with the Company Name's Privacy Policy. Most interactive websites use cookies to let us retrieve the users details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.\n License\n Unless otherwise stated, Company Name and/or its licensors own the intellectual property rights for all material on Website Name. All intellectual property rights are reserved. You may access this from Website Name for your own personal use subjected to restrictions set in these terms and conditions.\n You must not:\n Republish material from Website Name\n Sell, rent or sub-license material from Website Name\n Reproduce, duplicate or copy material from Website Name\n Redistribute content from Website Name\n This Agreement shall begin on the date hereof.\n Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Company Name does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Company Name, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Company Name shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website. App reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these \n Terms and Conditions.\n You warrant and represent that:\n You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;\n The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party\n The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy";

Widget termsAndConditionsText(){
  return const Text(" Welcome to My Books App!\nThese terms and conditions outline the rules and regulations for the use of Company Name's Website, located at mybooksapp.com.\nBy accessing this app we assume you accept these terms and conditions. Do not continue to use app if you do not agree to take all of the terms and conditions stated on this page.\n Cookies\n We employ the use of cookies. By accessing Website Name, you agreed to use cookies in agreement with the Company Name's Privacy Policy. Most interactive websites use cookies to let us retrieve the users details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.\n License\n Unless otherwise stated, Company Name and/or its licensors own the intellectual property rights for all material on Website Name. All intellectual property rights are reserved. You may access this from Website Name for your own personal use subjected to restrictions set in these terms and conditions.\n You must not:\n Republish material from Website Name\n Sell, rent or sub-license material from Website Name\n Reproduce, duplicate or copy material from Website Name\n Redistribute content from Website Name\n This Agreement shall begin on the date hereof.\n Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Company Name does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Company Name, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Company Name shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website. App reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these \n Terms and Conditions.\n You warrant and represent that:\n You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;\n The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party\n The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy"
  );
}

void _removeUserData(BuildContext context){
  context.read<AppBloc>().add(const TriggerAppEvent(0));
  context.read<HomePageBloc>().add(const HomePageDots(0));
  Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
  Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
}

Widget logoutButton(BuildContext context){
  return GestureDetector(
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
    child: Container(
      height: 100.h,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/icons/Logout.png")
          )
      ),
    ),
  );
}
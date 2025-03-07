import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/values/colors.dart';
import 'app_start_widgets.dart';
import 'bloc/app_start_page_blocs.dart';
import 'bloc/app_start_page_events.dart';
import 'bloc/app_start_page_states.dart';

class AppStartPage extends StatefulWidget {
  const AppStartPage({super.key});

  @override
  State<AppStartPage> createState() => _AppStartPageState();
}

class _AppStartPageState extends State<AppStartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(builder: (context, state){
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: buildPage(state.index),
            bottomNavigationBar: Container(
              width: 375.w,
              height: 58.h,
              decoration: BoxDecoration(
                  color: AppColors.warmPink,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]
              ),
              child: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (value) {
                  context.read<AppBloc>().add(TriggerAppEvent(value));
                },
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: AppColors.warmPink,
                unselectedItemColor: AppColors.unselectedGrey,
                items: bottomTabs,
              ),
            ),
          ),
        ),
      );
    });
  }
}

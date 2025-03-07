import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_book/pages/home_page/home_page.dart';
import 'package:my_book/pages/profile_page/settings_page/settings.dart';
import 'package:my_book/pages/sign_in_page/sign_in.dart';
import 'package:my_book/pages/welcome_page/bloc_providers.dart';
import 'package:my_book/pages/welcome_page/welcome.dart';
import 'common/routes/pages.dart';
import 'common/values/colors.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your app
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( providers:
      AppBlocProviders.allBlocProviders,
      child: ScreenUtilInit(
          minTextAdapt: true,
          //rebuildFactor: RebuildFactors.all,
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(
                      color: AppColors.warmPink,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white)),
           //home: const HomePage(),
            onGenerateRoute: AppPages.GenerateRouteSettings,
          )),
    );
  }
}

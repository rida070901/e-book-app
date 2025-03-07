import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/pages/application_start_page/bloc/app_start_page_events.dart';

import '../../../common/routes/route_names.dart';
import '../../../common/values/constants.dart';
import '../../../global.dart';
import '../../application_start_page/bloc/app_start_page_blocs.dart';
import 'package:my_book/common/widgets/base_text_widget.dart' as b;
import '../../common_widgets.dart';
import 'bloc/settings_blocs.dart';
import 'bloc/settings_states.dart';
import 'settings_widgets.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Settings"),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state){
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    b.reusableText("Terms & Conditions"),
                    SizedBox(height: 10.h),
                    termsAndConditionsText(),
                    //b.reusableText("s. Thefirston the internet, and I wanteit into t, I didn't safirston the internet, and I wanteit into t, I didn't safirston the internet, and I wanteit into t, I didn't safirston the internet, and I wanteit into t, I didn't sa firston the internet, and I wanteit into t, I didn't save it. The secondg to be a WORLD REChis is going to be a WORLD RECORD! This is actually myrious os other longest texts ever on the internet, and I wanted to make my own. So here it is! This is going to be a WORLD RECORD! This is actually my third attempt at doing this. The first time, I didn't save it. The second time, the Neocities editor crashed. Now I'm writing this in Notepad, then copying it into theHello, everyone! This is the LONGEST TEXT EVER! I was inspired by the various other longest texts ever on the internet, and I wanted to make my own. So here it is! This is going to be a WORLD RECORD! This is actually my third attempt at doing this. The first time, I didn't save it. The second time, the Neocities editor crashed. Now I'm writing this in Notepad, then copying it into the", fontSize: 16, fontWeight: FontWeight.normal),
                  ],
                ),
              ),
              logoutButton(context),
            ]
          );
        })
      )
    );
  }
}

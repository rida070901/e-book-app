import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/base_text_widget.dart';
import 'about_us_widgets.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar("About us"),
        body: SingleChildScrollView(
            child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("“I pronounce after all there is no pleasure like perusing!”- Jane Austen, Pride and Prejudice."),
                          SizedBox(height: 10.h),
                          aboutUsText(),
                          imageView(),
                          //b.reusableText("s. Thefirston the internet, and I wanteit into t, I didn't safirston the internet, and I wanteit into t, I didn't safirston the internet, and I wanteit into t, I didn't safirston the internet, and I wanteit into t, I didn't sa firston the internet, and I wanteit into t, I didn't save it. The secondg to be a WORLD REChis is going to be a WORLD RECORD! This is actually myrious os other longest texts ever on the internet, and I wanted to make my own. So here it is! This is going to be a WORLD RECORD! This is actually my third attempt at doing this. The first time, I didn't save it. The second time, the Neocities editor crashed. Now I'm writing this in Notepad, then copying it into theHello, everyone! This is the LONGEST TEXT EVER! I was inspired by the various other longest texts ever on the internet, and I wanted to make my own. So here it is! This is going to be a WORLD RECORD! This is actually my third attempt at doing this. The first time, I didn't save it. The second time, the Neocities editor crashed. Now I'm writing this in Notepad, then copying it into the", fontSize: 16, fontWeight: FontWeight.normal),
                        ],
                      ),
                    ),
                  ]
              )
        )
    );  }
}

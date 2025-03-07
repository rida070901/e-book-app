import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_book/common/values/colors.dart';

import '../../../common/widgets/base_text_widget.dart';
import 'contact_us_widgets.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar("Contact us"),
        body: SingleChildScrollView(
            child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          imageView(),
                          SizedBox(height: 30.h),
                          reusableText("You can contact us at:"),
                          SizedBox(height: 10.h),
                          reusableText("Email:  ebooks@yahoo.com", color: AppColors.strongGrey),
                          reusableText("Instagram:  ebooks_", color: AppColors.strongGrey),
                          reusableText("Facebook:  ebooks_", color: AppColors.strongGrey),
                        ],
                      ),
                    ),
                  ]
              )
        )
    );  }
}

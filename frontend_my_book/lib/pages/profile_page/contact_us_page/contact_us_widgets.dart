import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget contactUsText(){
  return const Text("\nDear readers,\n\nWe offer a tremendous gathering of books in the various classifications of Fiction, Non-fiction, Biographies, History, Religions, Self – Help, and Children. We likewise move in immense accumulation of Investments and Management, Computers, Engineering, Medical, College, and School content references books proposed by various foundations as scheduled the nation over. Besides this, we offer an expansive gathering of E-Books at a reasonable value.\nWe endeavor to broaden consumer loyalty by providing food with simple easy-using web indexes, brisk and easy-to-understand installment alternatives, and snappier conveyance frameworks. Upside to the majority of this, we are arranged to give energizing offers and charming limits on our books.\nToo, we modestly welcome every one of the merchants around the nation to band together with us. We will, without a doubt, give you the stage to many shimmering areas and develop the “Organization Name” family. We might want to thank you for shopping with us. You can keep in touch with us for any new musings at “email-id,” helping us to ad-lib for the peruser fulfillment.");
}

Widget imageView(){
  return Container(
    width: 400.w,
    height: 300.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        image: const DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/icons/heartmail.gif"),
        )
    ),
  );
}

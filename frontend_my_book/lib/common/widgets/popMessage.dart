import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../values/colors.dart';

popMessage(
    {required String message,
      Color bg = AppColors.warmPink,
      Color txt = Colors.white}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: bg,
      textColor: txt,
      fontSize: 14.sp);
}

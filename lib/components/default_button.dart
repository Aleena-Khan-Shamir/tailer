import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String? text;
  final void Function() press;
  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ElevatedButton(
          onPressed: press,
          child: Text(
            text!,
            style: TextStyle(fontSize: 16.sp),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          ),
        ),
      ),
    );
  }
}

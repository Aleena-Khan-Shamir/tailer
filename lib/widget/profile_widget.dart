import 'package:alma_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key, required this.appIcon, required this.appData})
      : super(key: key);
  final appIcon;
  final appData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        border: Border.all(),

        // color: Colors.amber
      ),
      child: Padding(
          padding: EdgeInsets.only(left: 15.w, top: 10.h),
          child: Row(
            children: [appIcon, SizedBox(width: 40.w), Text(appData)],
          )),
    );
  }
}

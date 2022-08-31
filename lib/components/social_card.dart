import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String icon;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.all(6.w),
        height: 40.h,
        width: 40.h,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}

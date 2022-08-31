import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {
  const FormError({Key? key, required this.errors}) : super(key: key);
  final List<String> errors;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            errors.length, (index) => errorFormText(error: errors[index]))
      ],
    );
  }

  Row errorFormText({String? error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/Error.svg",
          height: 7.w,
          width: 7.w,
        ),
        SizedBox(height: 5.h),
        Text(error!),
      ],
    );
  }
}

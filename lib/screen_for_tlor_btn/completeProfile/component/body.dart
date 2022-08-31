import 'package:alma_app/screen_for_tlor_btn/completeProfile/component/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyCPTailor extends StatelessWidget {
  const BodyCPTailor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 0.04.sw),
              Text(
                'Complete Profile',
                style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 25.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Please enter your valid data',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.02.sh),
              CompleteProfileFormT(),
              const Text(
                'By continuing your confirm that you agree\n with your term and condition ',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

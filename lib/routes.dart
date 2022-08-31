import 'package:alma_app/admin_panel/admin_home_screen.dart';
import 'package:alma_app/components/forgot_password/forgot_password_screen.dart';
import 'package:alma_app/photo/phot_screen.dart';
import 'package:alma_app/screen_for_tlor_btn/completeProfile/complete_profile.dart';
import 'package:alma_app/screen_for_tlor_btn/home_for_tailor/home_screen.dart';
import 'package:alma_app/screen_for_tlor_btn/home_for_tailor/post_card.dart';
import 'package:alma_app/screen_for_tlor_btn/home_for_tailor/profile_info.dart';
import 'package:alma_app/screen_for_tlor_btn/home_for_tailor/profilescreen.dart';
import 'package:alma_app/screen_for_tlor_btn/sign_In_for_tailor/sign_in.dart';
import 'package:alma_app/screens_for_customer_button/completeprofile_for_customer/complete_profile.dart';
import 'package:alma_app/screens_for_customer_button/home_for_customer/customer_home_screen.dart';
import 'package:alma_app/screens_for_customer_button/home_for_customer/post.dart';
import 'package:alma_app/screens_for_customer_button/sign_In_for_customer/sign_in.dart';
import 'package:alma_app/screens_for_customer_button/sign_up_for_customer/sign_up.dart';
import 'package:alma_app/widget/splash_screen.dart';
import 'package:alma_app/widget/welcome_screen.dart';
import 'package:alma_app/video/uploadvideo.dart';
import 'package:flutter/material.dart';

import 'screen_for_tlor_btn/signUp/sign_up.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  SignInScreenC.routeName: (context) => const SignInScreenC(),
  SignInScreenT.routeName: (context) => const SignInScreenT(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreenC.routeName: (_) => const SignUpScreenC(),
  SignUpScreenT.routeName: (context) => const SignUpScreenT(),
  CompleteProfileScreenT.routeName: (context) => const CompleteProfileScreenT(),
  CompleteProfileScreenC.routeName: (_) => const CompleteProfileScreenC(),
  CustomerHomeScreen.routeName: (context) => CustomerHomeScreen(),
  TailorHomeScreen.routeName: (context) => TailorHomeScreen(),
  PhotoPreviewScreen.routeName: (_) => const PhotoPreviewScreen(),
  Videoo.routeName: (context) => const Videoo(),
  PostCardForTailor.routeName: (_) => const PostCardForTailor(
        snap: null,
      ),
  PostCardForCustomer.routeName: (_) => const PostCardForCustomer(snap: null),
  ProfileInfo.routeName: (_) => const ProfileInfo(
        uid: '',
      ),
  ProfileS.routeName: (_) => const ProfileS(),
  AdminHome.routeName: (_) => const AdminHome(),
};

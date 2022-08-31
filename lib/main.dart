import 'package:alma_app/provider/user_provider.dart';
import 'package:alma_app/routes.dart';
import 'package:alma_app/screen_for_tlor_btn/completeProfile/complete_profile.dart';
import 'package:alma_app/widget/splash_screen.dart';
import 'package:alma_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),

          // home: CompleteProfileScreenT(),
          initialRoute: SplashScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}

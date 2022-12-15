import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app_flutter/bloc_observer.dart';
import 'package:social_app_flutter/layout/cubit/cubit.dart';
import 'package:social_app_flutter/layout/social_layout/social_layout_screen.dart';
import 'package:social_app_flutter/modules/socail_login/social_login_screen.dart';
import 'package:social_app_flutter/shared/components/constants.dart';
import 'package:social_app_flutter/shared/network/local/cache_helper.dart';
import 'package:social_app_flutter/shared/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
   uId = CacheHelper.getData(key: 'uid');
  Widget? widget;
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialSocialLoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialCubit()..getUserData(),
      child: MaterialApp(
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: startWidget),
    );
  }
}

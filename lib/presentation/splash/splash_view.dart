import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mena1/presentation/resources/color_manager.dart';
import 'package:mena1/presentation/resources/constant_manager.dart';
import 'package:mena1/presentation/resources/routes_manager.dart';

import '../../app/app_refs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
   const SplashView({Key? key}) : super(key: key);
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences=instance<AppPreferences>();

  Timer? _timer;
  _startDelay(){
    _timer=Timer(const Duration(seconds:AppConsts.splashDelay), _goNext);
  }
  _goNext()async{
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) =>
    {
      if (isUserLoggedIn){
        Navigator.pushReplacementNamed(context, Routes.loginRoute)
      } else
        {
          _appPreferences.isOnboardingScreenViewed().then((
              isOnboardingScreenViewed) =>
          {
            if(isOnboardingScreenViewed){
              Navigator.pushReplacementNamed(context, Routes.loginRoute)
            } else
              {
                Navigator.pushReplacementNamed(context, Routes.onBoardingRoute)
              }
          })
        }
    });
}
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(image: AssetImage("assets/images/splash_logo.png"),width: 200,height: 200,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();

  }
}

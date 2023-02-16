
import 'package:flutter/material.dart';
import 'package:mena1/app/di.dart';
import 'package:mena1/presentation/login/view/login_view.dart';
import 'package:mena1/presentation/main/main_view.dart';
import 'package:mena1/presentation/password/forgot_password_view.dart';
import 'package:mena1/presentation/register/register_view.dart';
import 'package:mena1/presentation/resources/strings_manager.dart';
import 'package:mena1/presentation/splash/splash_view.dart';
import 'package:mena1/presentation/store/store_details_view.dart';
import '../onboarding/view/onboarding_view.dart';
import 'strings_manager.dart';
class Routes{
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String storeDetailsRoute = '/storeDetails';
  static const String registerRoute = '/register';
  static const String mainRoute = '/main';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String onBoardingRoute = '/onboarding_view';

}
class RoutesGenerator {
  static Route<dynamic> getroute(RouteSettings settings){
    switch(settings.name)
    {
      case Routes.splashRoute :
       return MaterialPageRoute(builder: (_)=>const SplashView());
      case Routes.loginRoute :
        initLoginModule();
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case Routes.registerRoute :
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case Routes.forgotPasswordRoute :
        return MaterialPageRoute(builder: (_)=>const ForgotPasswordView());
      case Routes.onBoardingRoute :
        return MaterialPageRoute(builder: (_)=>const OnBoardingView());
      case Routes.storeDetailsRoute :
        return MaterialPageRoute(builder: (_)=>const StoreDetailsView());
      case Routes.mainRoute :
        return MaterialPageRoute(builder: (_)=>const MainView());
      default :
        return unDefinedRoute();


    }
  }
  static Route<dynamic> unDefinedRoute( ){
    return MaterialPageRoute(builder: (_)=>
    Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRoutesFound),
      ),
      body:  const Center(
        child: Text(AppStrings.noRoutesFound),
    )
    )
    );

  }
}
import 'package:mena1/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang=" prefsKeyLang";
const String prefOnBoardingViewed=" prefOnBoardingViewed";
const String prefsKeyIsUserLoggedIN=" prefsKeyIsUserLoggedIN";
class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);
  Future<String> getAppLanguage() async {
    String language=_sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isEmpty){
      return language;

    }else {
     return LanguageType.english.getValue();
    }
  }
  Future<void> setOnBoardingScreenViewed() async{
     _sharedPreferences.getBool(prefOnBoardingViewed);
  }
  Future<bool> isOnboardingScreenViewed() async{
    return _sharedPreferences.getBool(prefOnBoardingViewed) ??
    false ;
  }
  Future<void> setUserLoggedIn() async{
    _sharedPreferences.getBool(prefOnBoardingViewed);
  }
  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(prefOnBoardingViewed) ??
        false ;
  }
}
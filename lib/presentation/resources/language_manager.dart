import 'package:flutter/cupertino.dart';

enum LanguageType {english,arabic}

const String arabic="ar";
const String english="en";

extension LanguageTypeExtention on LanguageType {
  String getValue (){
    switch (this){
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;

    }
  }

}
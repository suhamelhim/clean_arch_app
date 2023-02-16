import 'package:flutter/cupertino.dart';
import 'package:mena1/presentation/resources/font_manager.dart';

TextStyle _getTextStyle (double fontSize,FontWeight fontWeight,Color color){
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstant.fontFamily,
    color: color
  );
}
TextStyle getRegularStyle({fontSize=FontSize.s12,color=Color}){
  return _getTextStyle(fontSize, FontWightManager.regular, color);
}
TextStyle getMediumStyle({fontSize=FontSize.s12,color=Color}){
  return _getTextStyle(fontSize, FontWightManager.medium, color);
}
TextStyle getLightStyle({fontSize=FontSize.s12,color=Color}){
  return _getTextStyle(fontSize, FontWightManager.light, color);
}
TextStyle getBoldStyle({fontSize=FontSize.s12,color=Color}){
  return _getTextStyle(fontSize, FontWightManager.bold, color);
}
TextStyle getSemiBoldStyle({fontSize=FontSize.s12,color=Color}){
  return _getTextStyle(fontSize, FontWightManager.semiBold, color);
}

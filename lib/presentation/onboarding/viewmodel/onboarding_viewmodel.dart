import 'dart:async';

import 'package:mena1/base/baseviewmodel.dart';
import 'package:mena1/domain/models.dart';
import 'package:mena1/presentation/resources/assets_manager.dart';
import 'package:mena1/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {
   final StreamController _streamController=StreamController<SliderViewObject>();
   late final List<SliderObject> _list;
   int _currentIndex=0;
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list=_getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex=++_currentIndex;
    if (nextIndex==_list.length){
      nextIndex=0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex=--_currentIndex;
    if (previousIndex==-1){
      previousIndex=_list.length-1;
    }return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex=index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;
void _postDataToView(){
  inputSliderViewObject.add(SliderViewObject(_list[_currentIndex],_list.length,_currentIndex));
}
  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);
  List<SliderObject> _getSliderData()=> [
    SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1, ImagesAssets.onboardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2, ImagesAssets.onboardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3, ImagesAssets.onboardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4, ImagesAssets.onboardingLogo4),
  ];
  
}

abstract class OnBoardingViewModelInput {
  int goNext();

  int goPrevious();

  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  Stream<SliderViewObject> get outputSliderViewObject;
}

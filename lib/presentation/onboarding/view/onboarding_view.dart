import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mena1/app/app_refs.dart';
import 'package:mena1/domain/models.dart';
import 'package:mena1/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:mena1/presentation/resources/assets_manager.dart';
import 'package:mena1/presentation/resources/color_manager.dart';
import 'package:mena1/presentation/resources/value_manager.dart';

import '../../../app/di.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final PageController _pageController = PageController();
  final AppPreferences _appPreferences=instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _appPreferences.setOnBoardingScreenViewed();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          height: 100,

          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: const Text(AppStrings.skip,
                      textAlign: TextAlign.end)

                  ,),
              ),
              _getBottomSheetWidget(sliderViewObject)

            ],
          ),
        ),

      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color:ColorManager.primary ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: const EdgeInsets.all(AppSize.s14),

            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImagesAssets.leftArrow),
              ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goPrevious(),
                      duration: const Duration(
                          milliseconds: 2),
                      curve: Curves.bounceInOut);
                }
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getproperCircle(i,sliderViewObject.currentIndex),
                )
            ],
          ),


          Padding(padding: const EdgeInsets.all(AppSize.s14),

            child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImagesAssets.rightArrow),
                ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goNext(),
                      duration: const Duration(
                          milliseconds:2),
                      curve: Curves.bounceInOut);
                }

            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(this._sliderObject, {Key? key,}) : super(key: key);
  final SliderObject _sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,

        ),
        Padding(padding: const EdgeInsets.all(AppSize.s8),
          child: Text(_sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .displayLarge,
          ),


        ),
        Padding(padding: const EdgeInsets.all(AppSize.s8),
          child: Text(_sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          ),


        ),
        const SizedBox(
          height: 60,

        ),
        SvgPicture.asset(_sliderObject.image),

      ],

    );
  }
}

Widget _getproperCircle(int index,int currentIndex) {
  if (index ==currentIndex ) {
    return SvgPicture.asset(ImagesAssets.hollowCircle);
  } else {
    return SvgPicture.asset(ImagesAssets.soldCircle);
  }
}

// int _getPreviousIndex() {
//   int previousIndex = --_currentIndex;
//   if (previousIndex == -1) {
//     previousIndex = _list.length - 1;
//   }
//   return previousIndex;
// }
//
// int _getNextIndex() {
//   int nextIndex = ++_currentIndex;
//   if (nextIndex == _list.length) {
//     nextIndex = 0;
//   }
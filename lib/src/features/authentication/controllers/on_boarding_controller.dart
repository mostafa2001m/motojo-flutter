import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/models/model_on_boarding.dart';
import 'package:motojo/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:motojo/src/features/authentication/screens/welcome/welcome_screen.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    onBoardingPageWidget(
        model: onBoardingModel(
            image: tOnBoardingPageImage1,
            title: tOnBoardingTitle1,
            subTitle: tOnBoardingSubTitle1,
            counterText: tOnBoardingCounter1,
            bgColor: tOnBoardingPage1Color)),
    onBoardingPageWidget(
        model: onBoardingModel(
            image: tOnBoardingPageImage2,
            title: tOnBoardingTitle2,
            subTitle: tOnBoardingSubTitle2,
            counterText: tOnBoardingCounter2,
            bgColor: tOnBoardingPage2Color)),
    onBoardingPageWidget(
        model: onBoardingModel(
            image: tOnBoardingPageImage3,
            title: tOnBoardingTitle3,
            subTitle: tOnBoardingSubTitle3,
            counterText: tOnBoardingCounter3,
            bgColor: tOnBoardingPage3Color))
  ];
  OnPageChangedCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

  skip() => controller.jumpToPage(page: 2);
  animateToNextSlide() {
    
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
    if (nextPage==3) {
      Get.to(()=>WelcomeScreen());
    }
  }
}

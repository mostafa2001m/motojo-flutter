// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/controllers/on_boarding_controller.dart';
import 'package:motojo/src/features/authentication/models/model_on_boarding.dart';
import 'package:motojo/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardinScreen extends StatelessWidget {
  onBoardinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obcontroller = OnBoardingController();
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        LiquidSwipe(
          pages: obcontroller.pages,
          slideIconWidget: Icon(Icons.arrow_back_ios),
          enableSideReveal: true,
          liquidController: obcontroller.controller,
          onPageChangeCallback: obcontroller.OnPageChangedCallback,
        ),
        Positioned(
            bottom: 40.0,
            child: OutlinedButton(
                onPressed: () => obcontroller.animateToNextSlide(),
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.black26),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    onPrimary: Colors.white),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration:
                      BoxDecoration(color: tDarkColor, shape: BoxShape.circle),
                  child: Icon(Icons.arrow_forward_ios),
                ))),
        Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => obcontroller.skip(),
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.grey),
              ),
            )),
        Obx(
          () => Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: obcontroller.currentPage.value,
                count: 3,
                effect: WormEffect(activeDotColor: tDarkColor, dotHeight: 5.0),
              )),
        )
      ]),
    );
  }
}

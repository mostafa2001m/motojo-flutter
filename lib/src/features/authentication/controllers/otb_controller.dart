import 'package:get/get.dart';
import 'package:motojo/src/features/authentication/screens/home/widgets/home_screen.dart';
import 'package:motojo/src/features/authentication/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance =>Get.find();

  void verifyOTP(String otp)async{
    var isVerified=await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(homeScreen()):Get.back();
  }
  
}
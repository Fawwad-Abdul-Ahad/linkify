import 'package:get/get.dart';

class SignupController extends GetxController{
  RxBool seePass = false.obs;

  checkPass(){
    seePass.value = !seePass.value;
  }
}
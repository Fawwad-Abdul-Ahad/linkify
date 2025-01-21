import 'package:get/get.dart';

class LoginController extends GetxController{
  RxBool seePass = false.obs;

  checkPass(){
    seePass.value = !seePass.value;
  }
}
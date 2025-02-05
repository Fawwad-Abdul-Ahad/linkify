import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:linkify/services/auth_service.dart';

class LoginController extends GetxController{
  RxBool seePass = false.obs;
  

  checkPass(){
    seePass.value = !seePass.value;
  }

 
}
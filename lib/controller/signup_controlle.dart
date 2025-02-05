import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  RxBool seePass = false.obs;
  Rxn<File> image = Rxn<File>(); // Using Rxn for nullable type

  void checkPass() {
    seePass.value = !seePass.value;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image(File(pickedFile.path)); // Assigning file directly to Rx variable
    }
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkify/common/text.dart';
import 'package:linkify/controller/signup_controlle.dart';
import 'package:linkify/services/auth_service.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final SignupController signupController = Get.put(SignupController());

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                SizedBox(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.4,
                  child: Center(
                    child: CommonText(
                      text: "Linkify",
                      textSize: 44,
                      fontWeightText: FontWeight.bold,
                      textColor: Colors.black,
                    ),
                  ),
                ),
                Obx(
                  () => Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: signupController.image.value != null
                            ? FileImage(signupController.image.value!)
                            : null,
                        child: signupController.image.value == null
                            ? Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: signupController.pickImage,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.camera_alt,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: screenHeight * 0.6,
                    width: screenWidth,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController, // Added Controller
                            style: GoogleFonts.poppins(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter an email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          TextFormField(
                            controller: nameController, // Added Controller
                            style: GoogleFonts.poppins(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          TextFormField(
                            controller: passController, // Added Controller
                            obscureText: !signupController.seePass.value,
                            style: GoogleFonts.poppins(color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: signupController.checkPass,
                                child: Icon(
                                  signupController.seePass.value
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                ),
                              ),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a password";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.08),
                          isLoading.value? CircularProgressIndicator():ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(width: 0),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 78, 78, 78),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                isLoading.value = true;
                                print("Form is valid");
                                UserCredential? userCredential =
                                    await authService.signupUser(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passController.text.trim(),
                                );

                                if (userCredential != null) {
                                  isLoading.value = false;
                                  print("successfull signup");
                                  // Navigate to another screen if needed
                                } else {
                                  isLoading.value  = false;
                                 print("Signup failed");
                                }
                              } else {
                                // isLoading.value = false
                                print("Form validation failed");
                              }
                            },
                            child: Center(
                              child: CommonText(
                                text: "Signup",
                                textSize: 18,
                                fontWeightText: FontWeight.w600,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: screenHeight * 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonText(
                                      text: "Have an account?",
                                      textSize: 14,
                                      fontWeightText: FontWeight.w500,
                                      textColor: const Color.fromARGB(
                                          255, 111, 111, 111),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: CommonText(
                                        text: "Signin.",
                                        textSize: 14,
                                        fontWeightText: FontWeight.w700,
                                        textColor: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

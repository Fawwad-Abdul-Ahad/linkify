import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkify/common/text.dart';
import 'package:linkify/controller/login_controller.dart';
import 'package:linkify/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    LoginController loginController = LoginController();
    return Scaffold(
        body:  SafeArea(child: Container(
          height: screenHeight*1,
          width: screenWidth*1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight*0.1,),
              SizedBox(
                height: screenHeight*0.1,
                width: screenWidth*0.4,
                child: Center(
                  child: Container(
                    // color: Colors.green,
                    child:CommonText(text: "Linkify", textSize: 44, fontWeightText: FontWeight.bold, textColor: Colors.black)
                  ),
                )),
                SizedBox(height: screenHeight*0.1,),
                Obx(()=>Container(
                  
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: screenHeight*0.5,
                  width: screenWidth*1,
                  // color: Colors.green,
                  child: Form(
                    key: formKey,
                    child: Column(
                    children: [
                      TextFormField(
                        
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "Email or username",
                          fillColor: Colors.grey,
                          hoverColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
            
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "please enter some text";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: screenHeight*0.04,
                      ),
                      TextFormField(
                       
                       obscureText: !loginController.seePass.value,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          
                          suffixIcon: GestureDetector(
                            onTap: (){
                              loginController.checkPass();
                            },
                            child: Icon(loginController.seePass.value?Icons.remove_red_eye:Icons.visibility_off)),
                          hintText: "Password",
                          fillColor: Colors.grey,
                          hoverColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
            
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "please enter some text";
                          }
                          return null;
                        },
                      ),
                       SizedBox(
                        height: screenHeight*0.08,
                      ),
                      ElevatedButton(
                        
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6), // Set border radius
      side: const BorderSide(
        // color: Color.fromARGB(255, 255, 255, 255), // Set border color
        width: 0, // Set border width
      ),
    ),
                          backgroundColor: const Color.fromARGB(255, 78, 78, 78)
                        ),
                        onPressed: (){
                        if(formKey.currentState!.validate()){
                          print("Ok");
                        }
                        else{
                          print("not ok");
                        }
                      }, child: Center(child:CommonText(text: "Login", textSize: 18, fontWeightText: FontWeight.w600, textColor: Colors.white))), 

                      Container(
                        width: screenWidth*1,
                        height: screenHeight*0.1,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(text: "Forgot your login details?", textSize: 14, fontWeightText: FontWeight.w500, textColor: const Color.fromARGB(255, 111, 111, 111)),
                                SizedBox(width: screenWidth*0.01,),
                                CommonText(text: "Get help logging in.", textSize: 14, fontWeightText: FontWeight.w700, textColor: Colors.black)
                              ],
                            ),
                            CommonText(text: "OR", textSize: 16, fontWeightText: FontWeight.w700, textColor: Colors.grey),  
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(text: "Don't have an accont?", textSize: 14, fontWeightText: FontWeight.w500, textColor: const Color.fromARGB(255, 111, 111, 111)),
                                SizedBox(width: screenWidth*0.01,),
                                InkWell(
                                  onTap: (){
                                    Get.to(SignupScreen());
                                  },
                                  child: CommonText(text: "Signup", textSize: 14, fontWeightText: FontWeight.w700, textColor: Colors.black))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            
                )),

            ],
                  ),
          ),
        )),
    );
  }
}
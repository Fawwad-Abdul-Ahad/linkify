import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:linkify/screens/dummy.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signupUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User created: ${userCredential.user!.uid}");

      // Save user data to Firestore
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        "userName": name,
        "email": email,
        "uid": userCredential.user!.uid,
        "followers": [],
        "following": [],
      }).then((_) {
        print("User Added Successfully");
      }).catchError((error) {
        print("Error adding user: $error");
      });

      return userCredential; // Return the user credentials on success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        stdout.write('Error: The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        stdout.write('Error: The account already exists for that email.');
      } else {
        stdout.write('Firebase Auth Error: ${e.message}');
      }
      return null; // Return null on failure
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }


  Future<UserCredential?> loginUser ({required String email,required String pass})async{
      try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: pass,
  );
  stdout.write("Successfull login");
  Get.to(Dummy());
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    Get.snackbar("Error", "User does not exiist");
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    Get.snackbar("Error", "Wrong Password");
    print('Wrong password provided for that user.');
  }
}
  }
}

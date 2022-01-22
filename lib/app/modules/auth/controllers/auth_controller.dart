import 'package:absensi/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  Stream<User?> streamAuthStatus() {
    var data = auth.authStateChanges();
    return data;
  }

  // Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void loginUser(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dialogError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialogError('Wrong password provided for that user.');
      }
    }
  }

  void logoutUser() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.AUTH);
    emailC.clear();
    passwordC.clear();
  }

  Future dialogError(String err) {
    return Get.defaultDialog(
        title: "Pemberitahuan",
        content: Text(
          err,
          style: TextStyle(
            fontSize: 18,
            color: Colors.red,
          ),
        ),
        onConfirm: () => Get.back(),
        textConfirm: "Baik",
        confirmTextColor: Colors.white,
        buttonColor: Colors.pink,
        contentPadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.only(top: 20));
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}

import 'package:absensi/app/modules/auth/views/forgot_view.dart';
import 'package:absensi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Center(
          child: Container(
            height: Get.height / 2.3,
            color: Colors.white,
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("LOGIN",
                    style: TextStyle(fontSize: 24, color: Colors.pink)),
                SizedBox(height: 20),
                inputEmail(),
                SizedBox(height: 10),
                inputPassword(),
                buttonForgot(),
                buttonAuth(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputEmail() {
    return TextField(
      style: TextStyle(color: Colors.pink),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          labelStyle: TextStyle(color: Colors.pink),
          hintText: "contoh@email.com",
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Colors.pink,
          ),
          hoverColor: Colors.pink,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink),
          )),
    );
  }

  Widget inputPassword() {
    return TextField(
      style: TextStyle(color: Colors.pink),
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          labelStyle: TextStyle(color: Colors.pink),
          hintText: "********",
          prefixIcon: Icon(
            Icons.password_outlined,
            color: Colors.pink,
          ),
          hoverColor: Colors.pink,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.pink),
          ),
        ),
    );
  }

  Widget buttonForgot() {
    return TextButton(
      onPressed: () => Get.to(()=> ForgotView(),), 
      child: Text("Lupa Password?",style: TextStyle(color: Colors.pink),),
    );
  }

  Widget buttonAuth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.HOME),
            child: Text("Masuk"),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                fixedSize: Size(Get.width / 2, 50),
                primary: Colors.pink),
          ),
        ),
      ],
    );
  }
}

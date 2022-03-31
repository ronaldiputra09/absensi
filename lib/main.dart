import 'package:absensi/app/modules/auth/controllers/auth_controller.dart';
import 'package:absensi/app/widgets/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data);
          return GetMaterialApp(
            title: "Absensi",
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.AUTH,
            getPages: AppPages.routes,
            // home: snapshot.data == null ? AuthView() : HomeView(),
          );
        }
        return Loading();
      },
    );
  }
}

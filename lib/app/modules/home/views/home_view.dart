import 'package:absensi/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: buttonAbsen(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('ABSEN'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => profileAbsen(),
            icon: Icon(Icons.person_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_rounded),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) => ListTile(
              onTap: () {},
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.pink,
                  ),
                ],
              ),
              title: Row(
                children: [
                  Expanded(
                      child: Text(
                    "Masuk : 07.30 WIB",
                    style: TextStyle(color: Colors.red),
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: Text(
                    "Pulang : 07.30 WIB",
                    style: TextStyle(color: Colors.green),
                  )),
                ],
              ),
              subtitle: Text(
                'Lokasi : Indralaya',
              ),
              trailing: Icon(Icons.arrow_forward_outlined),
            ),
          ),
        ));
  }

  Widget buttonAbsen() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => bottomSheetAbsen(),
        child: Text("ABSEN SEKARANG"),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.maxFinite, 60),
          primary: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Future profileAbsen() {
    return Get.defaultDialog(
      title: "Profil",
      titlePadding: EdgeInsets.only(top: 20),
      contentPadding: EdgeInsets.all(20),
      content: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            maxRadius: 50,
          ),
          SizedBox(height: 10),
          Text(
            "Ronaldi Putra",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            // "emailnyaronal@gmail.com"
            authC.user!.uid,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => authC.logoutUser(),
            child: Text("Keluar"),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.maxFinite, 60),
              primary: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> bottomSheetAbsen() {
    return Get.bottomSheet(
      Container(
        height: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // form tanggal dan jam
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: Colors.pink,
                          ),
                        ),
                        Text("07.30 WIB")
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.pink,
                          ),
                        ),
                        Text("07.30 WIB")
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // form lokasi
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.pink,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Indralaya Utara',
                                  hintStyle: TextStyle(color: Colors.pink)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("ABSEN"),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.maxFinite, 60),
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

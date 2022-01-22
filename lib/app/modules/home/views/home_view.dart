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
          elevation: 0,
          backgroundColor: Colors.pink,
          title: Text('ABSEN'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.defaultDialog(
              title: "KELUAR",
              middleText: "Yakin Mau Keluar?",
              onConfirm: () {
                Get.back();
                Get.back();
                authC.logoutUser();
              },
              textConfirm: "Yakin",
              buttonColor: Colors.pink,
              confirmTextColor: Colors.white,
              textCancel: "Batal",
              cancelTextColor: Colors.pink,
            ),
            icon: Icon(Icons.logout),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              color: Colors.pink,
              child:  
                Obx(()=>Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.tanggal.toString(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10),
                    Text( controller.jam.toString() + ' WIB',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Latitude : -3928382', style: TextStyle(color: Colors.white),),
                        SizedBox(width: 10),
                        Text('Longitude : -129102919', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Indralaya', style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ),
            Expanded(
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
            ),
          ],
        ));
  }

  Widget buttonAbsen() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => controller.getTanggal(),
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

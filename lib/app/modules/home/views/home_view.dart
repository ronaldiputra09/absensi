import 'package:absensi/app/modules/auth/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buttonTambah(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink,
        title: Text('MASTER DATA'),
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
              onPressed: () {
                Get.defaultDialog(
                    title: "Ganti Master Data",
                    textConfirm: "Yakin",
                    buttonColor: Colors.pink,
                    confirmTextColor: Colors.white,
                    textCancel: "Batal",
                    cancelTextColor: Colors.pink,
                    contentPadding: EdgeInsets.all(20),
                    content: Column(
                      children: [
                        TextField(
                          controller: controller.lat,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: "Latitude",
                          ),
                        ),
                        TextField(
                          controller: controller.long,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: "Longitude",
                          ),
                        ),
                      ],
                    ),
                    onConfirm: () {
                      controller.latitudeM.value = controller.lat.text;
                      controller.longitudeM.value = controller.long.text;
                      Get.back();
                    });
              },
              icon: Icon(Icons.change_circle_outlined))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: Get.height * 0.15,
            width: Get.width,
            color: Colors.pink,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.tanggal.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Latitude : ' + controller.latitudeM.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Longitude : ' + controller.longitudeM.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Lokasi anda sekarang di ${controller.alamat.toString()}.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: controller.ambilList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var listData = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.pink,
                            ),
                          ],
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Latitude : ",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text(
                                  "${(listData[index].data() as Map<String, dynamic>)["latitude"]}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Longitude :",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text(
                                  "${(listData[index].data() as Map<String, dynamic>)["longitude"]}",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            )
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              '${(listData[index].data() as Map<String, dynamic>)["tanggal"]} ',
                            ),
                            Text('di '),
                            Text(
                              '${(listData[index].data() as Map<String, dynamic>)["alamat"]}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonTambah() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          Get.defaultDialog(
            title: "TAMBAH DATA",
            titlePadding: EdgeInsets.only(top: 10),
            contentPadding: EdgeInsets.all(10),
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tanggal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(controller.tanggal.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Jam", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(controller.jam.toString() + " WIB"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tempat",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(controller.alamat.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Latitude",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Obx(() => Text(controller.latitude.toString())),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Longitude",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Obx(() => Text(controller.longitude.toString())),
                  ],
                ),
              ],
            ),
            onConfirm: () {
              Get.back();
              Get.back();
              controller.isAbsen.value = true;
              controller.hitungJarak();
            },
            textConfirm: "Yakin",
            buttonColor: Colors.pink,
            confirmTextColor: Colors.white,
            textCancel: "Batal",
            cancelTextColor: Colors.pink,
          );
        },
        child: Text("TAMBAH DATA"),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Get.width, Get.height * 0.06),
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

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  TextEditingController lat = TextEditingController();
  TextEditingController long = TextEditingController();
  var tanggal = ''.obs;
  var jamTampilan = ''.obs;
  var jam = ''.obs;
  var latitudeM = "-3.2604972".obs;
  var longitudeM = "104.6523712".obs;
  var latitude = "".obs;
  var longitude = "".obs;
  var alamat = 'Tidak ditemukan.'.obs;
  var isAbsen = false.obs;
  var docId = ''.obs;
  late StreamSubscription<Position> streamSubscription;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Object?>> ambilList() {
    CollectionReference absens = firestore.collection("absens");
    return absens
        .where('idUser', isEqualTo: auth.currentUser?.uid.toString())
        .snapshots();
  }

  void hitungJarak() {
    var R = 6378.137; // Radius bumi per KM
    var dLat = double.parse(latitude.value) * pi / 180 -
        double.parse(latitudeM.value) * pi / 180;
    var dLon = double.parse(longitude.value) * pi / 180 -
        double.parse(longitudeM.value) * pi / 180;
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(double.parse(latitudeM.value) * pi / 180) *
            cos(double.parse(latitude.value) * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;
    var hasil = d * 1000;
    var konver = hasil.round();
    print(konver);
    if (konver <= 50) {
      addData();
    } else {
      dialogError("Anda melebihi 50M");
    }
  }

  addData() {
    CollectionReference absens =
        FirebaseFirestore.instance.collection('absens');

    if (alamat.value != 'Tidak ditemukan') {
      return absens
          .add({
            'idUser': auth.currentUser?.uid,
            'tanggal': tanggal.toString(),
            'alamat': alamat.toString(),
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
            'created_at': DateTime.now().toIso8601String(),
          })
          .then((value) => Get.defaultDialog(
                title: "Pengumuman",
                middleText: "BERHASIL",
                textConfirm: "Oke",
                buttonColor: Colors.pink,
                confirmTextColor: Colors.white,
                onConfirm: () => Get.back(),
              ))
          .catchError(
            (error) => Get.defaultDialog(
              title: "Pengumuman",
              middleText: "GAGAL",
              textConfirm: "Oke",
              buttonColor: Colors.pink,
              confirmTextColor: Colors.white,
            ),
          );
    }
    Get.defaultDialog(
      title: "Pengumuman",
      middleText: "AKTIFKAN LOKASI ANDA",
      textConfirm: "Oke",
      buttonColor: Colors.pink,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  // get data Tanggal
  void getTanggal() {
    var date = DateTime.now();
    tanggal.value = DateFormat('dd MMMM yyyy').format(date);
  }

  // get data Jam
  void getJam() {
    Timer.periodic(Duration(seconds: 1), (Timer) {
      var date = DateTime.now();
      jamTampilan.value = DateFormat('kk.mm.ss').format(date);
      jam.value = DateFormat('kk.mm').format(date);
    });
  }

  // get data latitude & longitude
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return dialogError('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return dialogError('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return dialogError(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      getAddress(position);
    });
  }

  // get data address
  Future<void> getAddress(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    alamat.value = place.subLocality.toString();
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
      titlePadding: EdgeInsets.only(top: 20),
    );
  }

  @override
  void onInit() {
    getTanggal();
    getJam();
    getLocation();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    lat.dispose();
    long.dispose();
  }
}

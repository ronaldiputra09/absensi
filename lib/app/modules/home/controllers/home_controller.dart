import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var tanggal = ''.obs;
  var jam = ''.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
  var alamat = ''.obs;

  void getTanggal() {
    var date = DateTime.now();
    tanggal.value = DateFormat('dd MMMM yyyy').format(date);
  }

  void getJam() {
    Timer.periodic(Duration(seconds: 1), (Timer) {
      var date = DateTime.now();
      jam.value = DateFormat('kk.mm.ss').format(date);
    });
  }

  @override
  void onInit() {
    getTanggal();
    getJam();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

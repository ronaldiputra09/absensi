import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var tanggal = ''.obs;
  var jam = ''.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
  var alamat = ''.obs;
  late StreamSubscription<Position> streamSubscription;

  // get data Tanggal
  void getTanggal() {
    var date = DateTime.now();
    tanggal.value = DateFormat('dd MMMM yyyy').format(date);
  }

  // get data Jam
  void getJam() {
    Timer.periodic(Duration(seconds: 1), (Timer) {
      var date = DateTime.now();
      jam.value = DateFormat('kk.mm.ss').format(date);
    });
  }

  // get data latitude & longitude
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
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
  void onClose() {}
}

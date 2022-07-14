import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;

class ReportAktivitasController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  String? adressReport;
  Position? position;
  List<Placemark>? placemarks;
  final storage = s.FirebaseStorage.instance;
  RxBool isLoading = false.obs;
  RxBool isLoadingReport = false.obs;
  RxBool isLoadingColor = false.obs;
  RxBool isLoadingReportColor = false.obs;

  Future<Position> determinePosition() async {
    
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoading.value = false;
      isLoadingColor.value = false;
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading.value = false;
        isLoadingColor.value = false;
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLoading.value = false;
      isLoadingColor.value = false;
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLokasi() async {
    isLoading.value = true;
    isLoadingColor.value = true;
    await determinePosition();
    position = await Geolocator.getCurrentPosition();
    isLoading.value = false;
    isLoadingColor.value = false;

    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    adressReport =
        await "${placemarks![0].street}, ${placemarks![0].subAdministrativeArea}, ${placemarks![0].administrativeArea}";
    update();
    
  }

  void pickImage() async {
    if (position != null) {
      photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        print(photo!.name);
        print(photo!.path);
        print("selesei");
      } else {
        Get.snackbar("Terjadi kesalahan", "Tidak ditemukan foto");
      }
    } else {
      Get.snackbar("Terjadi kesalahan", "Lokasi tidak ditemukan");
    }

    update();
  }

  Future<void> reportAktivitas() async {
    
    String uid = auth.currentUser!.uid;
    DateTime now = DateTime.now();
    String todayDocStorageId =
        DateFormat.yMd().format(now).replaceAll('/' '', "-");
    String todayDocFirestoreId =
        DateFormat.yMd().add_Hm().format(now).replaceAll('/' '', "-");
    

    final storageRef = storage.ref();
    final mountainsRef = storageRef.child("report.jpg");
    final mountainImagesRef = storageRef.child(
        "${todayDocStorageId}/${auth.currentUser!.email}-${todayDocFirestoreId}.jpg"); // NEXT GET NAMANYA AJA
    //BUAT GET LOKASI//

    //SELESEI
    //BUAT STORAGE HANDLE FOTO

    // DocumentReference<Map<String, dynamic>> collSales =
    //     await firestore.collection("Sales").doc(uid);
    // print(collSales);
    // Future<DocumentSnapshot<Map<String, dynamic>>> collSnapSales =
    //     collSales.get();
    isLoadingReport.value = true;
    isLoadingReportColor.value = true;
    if (photo != null && position != null) {
      
      File file = File(photo!.path);

      await mountainImagesRef.putFile(file);
      CollectionReference<Map<String, dynamic>> collReport =
          await firestore.collection("Sales").doc(uid).collection("report");
      print(collReport);
      QuerySnapshot<Map<String, dynamic>> collSnapReport =
          await collReport.get();
      collReport.doc(todayDocFirestoreId).set({
        "adress": adressReport,
        "latitude": position!.latitude,
        "longtitude": position!.longitude,
        "date": now.toIso8601String(),
      });
      Get.back();
      Get.snackbar("Berhasil", "Melakukan report aktivitas");
    } else {
      isLoadingReport.value = false;
      isLoadingReportColor.value = false;
      Get.snackbar("Terjadi kesalahan", "Foto dan Lokasi tidak ditemukan");
    }
  }
}

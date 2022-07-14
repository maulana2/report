import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSalesController extends GetxController {
  TextEditingController kodeSalesC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController kodeMitraC = TextEditingController();
  TextEditingController daerahTelkomC = TextEditingController();
  TextEditingController stoC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingAddSales = false.obs;
  RxBool isLoadingAddSalesCollor = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  Future<void> prosesAddSales() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddSales.value = true;

      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential credentialAdmin = await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: passAdminC.text);

        final salesCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );

        print(salesCredential);
        if (salesCredential.user != null) {
          String uid = salesCredential.user!.uid;

          await firestore.collection("Sales").doc(uid).set({
            "name": nameC.text,
            "kode sales": kodeSalesC.text,
            "email": emailC.text,
            "kode mitra": kodeMitraC.text,
            "daerah telkom": daerahTelkomC.text,
            "STO": stoC.text,
            "uid": uid,
            "role": "sales",
            "createdAt": DateTime.now().toIso8601String(),
          });
          await salesCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential credentialAdmin =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);

          Get.back(); // tutup dialog
          Get.back(); // back home
          Get.snackbar("Berhasil", "Berhasil menambahkan sales");
          isLoadingAddSales.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingAddSales.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password terlalu singkat");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan", "Email sales sudah terdaftar");
        } else if (e.code == 'wrong-password') {
          isLoadingAddSales.value = false;
          Get.snackbar("Terjadi Kesalahan", "Password salah");
        } else {
          Get.snackbar("Terjadi Kesalahan", "${e.code}");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan sales");
        print("ini kesalahannya $e");
      }
    } else {
      isLoadingAddSales.value = false;
      isLoading.value = false;
      Get.snackbar("Terjadi kesalahan", "ini");
    }
  }

  Future<void> addSales() async {
    if (kodeSalesC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = false;
      Get.defaultDialog(
          title: "Masukan password untuk validasi admin",
          content: Column(
            children: [
              Text("Masukan password"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passAdminC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Masukan password",
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
          actions: [
            OutlinedButton(
                onPressed: () {
                  isLoading.value = false;
                  Get.back();
                },
                child: Text("Cancel")),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (isLoadingAddSales.isFalse) {
                    await prosesAddSales();
                  }
                },
                child: Text(
                    isLoadingAddSales.isFalse ? "Add Sales" : "Loading...")))
          ]);
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "Kode sales, Nama, dan email harus di isi");
    }
  }
}

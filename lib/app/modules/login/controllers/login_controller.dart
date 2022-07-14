import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingColor = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      isLoadingColor.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);
        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passwordC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: "Terjadi kesalahan",
                middleText:
                    "Email belum terverifikasi, silakan verifikasi email di kotak masuk",
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        isLoading.value = false;
                        isLoadingColor.value = false;
                        Get.back();
                      },
                      child: Text("Cancel")),
                  ElevatedButton(
                      onPressed: () {
                        try {
                          credential.user!.sendEmailVerification();
                          Get.back();
                          Get.snackbar("Berhasil",
                              "Berhasil mengirim email verifikasi silakan check kotak masuk/spam");
                          isLoading.value = false;
                        } catch (e) {
                          isLoading.value = false;
                          isLoadingColor.value = false;
                          Get.snackbar("Terjadi kesalahan",
                              "Tidak dapat mengirim verifikasi login silakan hubungi admin");
                        }
                      },
                      child: Text("Kirim ulang email verifikikasi"))
                ]);
          }
        }
        print(credential);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        isLoadingColor.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi kesalahan", "Email tidak ditemukan");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi kesalahan", "Password salah");
        }
      } catch (e) {
        isLoading.value = false;
        isLoadingColor.value = false;
        Get.snackbar("Terjadi kesalahan", "Tidak dapat login");
      }
    } else {
      Get.snackbar("Terjadi kesalahan", "Email dan Password harus di isi");
    }
  }
}

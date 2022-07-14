import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoadingColor = false.obs;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      isLoadingColor.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);

        Get.back();

        Get.snackbar(
          
            "Berhasil", "Berhasil mengirim reset password silakan check email");
      } on FirebaseException catch (e) {
        Get.snackbar("Terjadi kesalahan", "${e.code}");
      } finally {
        isLoading.value = false;
        isLoadingColor.value = false;
      }
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:report/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController newPasswordC = TextEditingController();
  RxBool isLoading = false.obs;

  void newPassword() async {
    if (newPasswordC.text.isNotEmpty) {
      isLoading.value = true;
      
      if (newPasswordC.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPasswordC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPasswordC.text);
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
                "Terjadi kesalahan", "Password harus terdiri dari 6 karakter");
          }
          print(e);
        } catch (e) {
          Get.snackbar("Terjadi kesalahan", "Silakan hubungi admin");
        } finally {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Terjadi kesalahan", "Silakan perbarui password default");
      }
    } else {
      isLoading.value = false;
      
      Get.snackbar("Terjadi kesalahan", "Password tidak boleh kosong");
    }
  }
}

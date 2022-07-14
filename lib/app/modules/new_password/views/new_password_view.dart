import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:report/app/routes/app_pages.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  controller.auth.signOut();
                  Get.offAllNamed(Routes.LOGIN);
                },
                icon: Icon(Icons.logout))
          ],
          title: Text('Ganti password'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.newPasswordC,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Masukan password baru",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.newPassword();
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? "Ganti password"
                    : "Loading...")))
          ],
        ));
  }
}

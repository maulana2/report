import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffEE2E24),
          title: Text('Reset Password'),
          centerTitle: true,
        ),
        body: ListView(padding: EdgeInsets.all(20), children: [
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(() => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse && controller.isLoadingColor.isFalse) {
                  controller.sendEmail();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(controller.isLoadingColor.isFalse ? 0xffEE2E24 : 0xff6D6E71),
              ),
              child: Text(
                  controller.isLoading.isFalse ? "Kirim emai" : "Loading"))),
        ]));
  }
}

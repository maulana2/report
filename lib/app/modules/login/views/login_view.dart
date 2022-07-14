import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:report/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
      child: ListView(

        children: [
          Image.asset("assets/logo_telkom.png"),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Email"),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.passwordC,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Password"),
          ),
          SizedBox(
            height: 30,
          ),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse && controller.isLoading.isFalse) {
                  await controller.login();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(controller.isLoading.isFalse ? 0xffEE2E24 : 0xff6D6E71),
              ),
              child:
                  Text(controller.isLoading.isFalse ? "Login" : "Loading..."))),
          OutlinedButton(
              onPressed: () {
                Get.toNamed(Routes.RESET_PASSWORD);
              },
              child: Text(
                "Reset Password",
                style: TextStyle(
                  color: Color(0xffEE2E24),
                ),
              ))
        ],
      ),
    ));
  }
}

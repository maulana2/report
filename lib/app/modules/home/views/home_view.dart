import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:report/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          actions: [
            Obx(() => IconButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.isLoading.value = true;
                    FirebaseAuth.instance.signOut();

                    Get.offAllNamed(Routes.LOGIN);
                  }
                },
                icon: controller.isLoading.isFalse
                    ? Icon(
                        Icons.logout_rounded,
                        color: Colors.black,
                      )
                    : CircularProgressIndicator()))
          ],
          title: Text(
            'Report Aktivitas Sales',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.streamRole(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  }
                  String role = snap.data!.data()!["role"];
                  String name = snap.data!.data()!["name"];
                  if (role == "admin") {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${name}",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff6D6E71),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome to report aktivitas sales",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffEE2E24),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          leading: Icon(Icons.person_add),
                          onTap: () {
                            Get.toNamed(Routes.ADD_SALES);
                          },
                          title: Text("Tambah sales report"),
                          tileColor: Color(0xffF7ECDE),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          leading: Icon(Icons.border_color),
                          onTap: () {
                            Get.toNamed(Routes.LAPORAN_AKTIVITAS);
                          },
                          title: Text("Laporan aktivitas Sales"),
                          tileColor: Color(0xffF7ECDE),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${name}",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff6D6E71),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome to report aktivitas sales",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffEE2E24),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          leading: Icon(Icons.library_books),
                          onTap: () {
                            Get.toNamed(Routes.REPORT_AKTIVITAS);
                          },
                          title: Text("Report Aktivitas"),
                          tileColor: Color(0xffF7ECDE),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          leading: Icon(Icons.person),
                          onTap: () {
                            Get.toNamed(Routes.AKTIVITAS_KU);
                          },
                          title: Text("AktivitasKu"),
                          tileColor: Color(0xffF7ECDE),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ));
  }
}

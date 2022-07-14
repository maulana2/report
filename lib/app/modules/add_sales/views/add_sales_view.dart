import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_sales_controller.dart';

class AddSalesView extends GetView<AddSalesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
              )),
          title: Text(
            'Tambah sales report',
          ),
          centerTitle: true,
          backgroundColor: Color(0xffEE2E24),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: controller.kodeSalesC,
              decoration: InputDecoration(
                  labelText: "Kode Sales", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: controller.nameC,
              decoration: InputDecoration(
                  labelText: "Nama", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: controller.kodeMitraC,
              decoration: InputDecoration(
                  labelText: "Kode mitra", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: controller.daerahTelkomC,
              decoration: InputDecoration(
                  labelText: "Daerah telkom", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: controller.stoC,
              decoration: InputDecoration(
                  labelText: "STO", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xffEE2E24)),
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.addSales();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? "Daftar" : "Loading",
                ),
              ),
            ),
          ],
        ));
  }
}

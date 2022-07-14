import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/report_aktivitas_controller.dart';

class ReportAktivitasView extends GetView<ReportAktivitasController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEE2E24),
        title: Text('Report Aktivitas Sales'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<ReportAktivitasController>(
                  builder: (c) {
                    if (c.adressReport != null) {
                      return TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "${c.adressReport}",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      );
                    } else {
                      return TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "Lokasi tidak ditemukan",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size(200, 40),
                      primary: Color(controller.isLoading.isFalse &&
                              controller.isLoadingReportColor.isFalse
                          ? 0xffEE2E24
                          : 0xff6D6E71),
                    ),
                    onPressed: () async {
                      if (controller.isLoading.isFalse &&
                          controller.isLoadingReport.isFalse) {
                        await controller.getLokasi();
                      }
                    },
                    child: Text(controller.isLoading.isFalse
                        ? "Mendapatkan lokasi"
                        : "Loading..."))),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<ReportAktivitasController>(
                      builder: (c) {
                        if (c.photo == null) {
                          return Text("Tidak ada foto");
                        } else {
                          return Container(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              File(c.photo!.path),
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                    OutlinedButton(
                        onPressed: () {
                          controller.pickImage();
                        },
                        child: Text("ambil foto")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(200, 40),
                        primary: Color(controller.isLoadingReportColor.isFalse
                            ? 0xffEE2E24
                            : 0xff6D6E71),
                      ),
                      onPressed: () async {
                        if (controller.isLoadingReport.isFalse &&
                            controller.isLoadingReportColor.isFalse) {
                          await controller.reportAktivitas();
                        }
                      },
                      child: Text(controller.isLoadingReport.isFalse
                          ? "Simpan"
                          : "Menyimpan"))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

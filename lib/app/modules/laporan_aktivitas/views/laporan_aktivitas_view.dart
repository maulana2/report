import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/laporan_aktivitas_controller.dart';

class LaporanAktivitasView extends GetView<LaporanAktivitasController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LaporanAktivitasView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LaporanAktivitasView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

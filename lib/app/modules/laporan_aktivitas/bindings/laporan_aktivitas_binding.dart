import 'package:get/get.dart';

import '../controllers/laporan_aktivitas_controller.dart';

class LaporanAktivitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanAktivitasController>(
      () => LaporanAktivitasController(),
    );
  }
}

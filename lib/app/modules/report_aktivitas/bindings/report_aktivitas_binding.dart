import 'package:get/get.dart';

import '../controllers/report_aktivitas_controller.dart';

class ReportAktivitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportAktivitasController>(
      () => ReportAktivitasController(),
    );
  }
}

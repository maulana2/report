import 'package:get/get.dart';

import '../controllers/aktivitas_ku_controller.dart';

class AktivitasKuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AktivitasKuController>(
      () => AktivitasKuController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/add_sales_controller.dart';

class AddSalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSalesController>(
      () => AddSalesController(),
    );
  }
}

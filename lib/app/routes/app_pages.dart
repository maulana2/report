import 'package:get/get.dart';

import 'package:report/app/modules/AktivitasKu/bindings/aktivitas_ku_binding.dart';
import 'package:report/app/modules/AktivitasKu/views/aktivitas_ku_view.dart';
import 'package:report/app/modules/add_sales/bindings/add_sales_binding.dart';
import 'package:report/app/modules/add_sales/views/add_sales_view.dart';
import 'package:report/app/modules/home/bindings/home_binding.dart';
import 'package:report/app/modules/home/views/home_view.dart';
import 'package:report/app/modules/laporan_aktivitas/bindings/laporan_aktivitas_binding.dart';
import 'package:report/app/modules/laporan_aktivitas/views/laporan_aktivitas_view.dart';
import 'package:report/app/modules/login/bindings/login_binding.dart';
import 'package:report/app/modules/login/views/login_view.dart';
import 'package:report/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:report/app/modules/new_password/views/new_password_view.dart';
import 'package:report/app/modules/report_aktivitas/bindings/report_aktivitas_binding.dart';
import 'package:report/app/modules/report_aktivitas/views/report_aktivitas_view.dart';
import 'package:report/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:report/app/modules/reset_password/views/reset_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SALES,
      page: () => AddSalesView(),
      binding: AddSalesBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_AKTIVITAS,
      page: () => ReportAktivitasView(),
      binding: ReportAktivitasBinding(),
    ),
    GetPage(
      name: _Paths.AKTIVITAS_KU,
      page: () => AktivitasKuView(),
      binding: AktivitasKuBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_AKTIVITAS,
      page: () => LaporanAktivitasView(),
      binding: LaporanAktivitasBinding(),
    ),
  ];
}

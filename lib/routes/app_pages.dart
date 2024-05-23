import 'package:bluetooth_sharing/routes/app_routes.dart';
import 'package:bluetooth_sharing/views/home/home_binding.dart';
import 'package:bluetooth_sharing/views/home/home_view.dart';

import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page:  () =>  HomeView() ,
      binding: HomeBinding(),
    ),
  ];
}

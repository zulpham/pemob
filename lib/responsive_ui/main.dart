import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'route/app_routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

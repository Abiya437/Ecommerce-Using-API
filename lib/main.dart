import 'package:ecommerce_task/controller/product/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/app.dart';
import 'controller/product_screen/cart_controller.dart';

void main() {
  Get.put(CartController());
  Get.put(ProductController());
  runApp(const MyApp());
}



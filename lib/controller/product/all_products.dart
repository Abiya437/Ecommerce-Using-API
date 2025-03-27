import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Model/all_products/all_products_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        products.value = data.map((e) => Product.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}

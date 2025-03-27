import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubProductsController extends GetxController {
  var isLoading = true.obs;
  var products = [].obs;

  void fetchProducts(String category) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/$category'));
      if (response.statusCode == 200) {
        print('fetch subproducts api sucessfully');
        products.value = json.decode(response.body);
      } else {
        print('fetch subproducts api failed');

        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      print('fetch subproducts api failed in catch');

      Get.snackbar('Error', 'Something went wrong: \$e');
    } finally {
      isLoading(false);
    }
  }
}
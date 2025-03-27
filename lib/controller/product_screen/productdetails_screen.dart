import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailsController extends GetxController {
  var isLoading = true.obs;
  var product = {}.obs;

  void fetchProductDetails(int productId) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));
      if (response.statusCode == 200) {
        print('fetch productdetails api sucessfully');
        product.value = json.decode(response.body);
      } else {
        print('fetch productdetails api failed');
        Get.snackbar('Error', 'Failed to load product details');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: \$e');
    } finally {
      isLoading(false);
    }
  }
}
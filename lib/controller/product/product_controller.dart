import 'package:ecommerce_task/controller/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryController extends GetxController {
  var categories = <String>[].obs;
  var isLoading = true.obs;

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

      if (response.statusCode == 200) {
        categories.value = List<String>.from(json.decode(response.body));
      } else {
        print('Failed to load categories');
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
    finally {
      isLoading(false);
    }
  }
}

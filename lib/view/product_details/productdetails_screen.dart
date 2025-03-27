import 'package:ecommerce_task/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_screen/cart_controller.dart';
import '../../controller/product_screen/productdetails_screen.dart';
import '../widgets/common_appbar.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;
  ProductDetailsPage({super.key, required this.productId});

  final ProductDetailsController productController = Get.put(ProductDetailsController());
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    productController.fetchProductDetails(productId);

    return Scaffold(
      appBar:  CommonAppBar(title: 'Product Details', actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Get.toNamed(AppRoutes.cartPage);
          },
        ),
      ],),
      body: Obx(
            () => productController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                    image: productController.product['image'] != null
                        ? DecorationImage(
                      image: NetworkImage(productController.product['image']),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '\₹${productController.product['price']} ',
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${productController.product['title']} ',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${productController.product['category']} ',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Product Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${productController.product['description']} ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                      onPressed: () {
                        cartController.addToCart(Map<String, dynamic>.from(productController.product));
                      },
                    child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
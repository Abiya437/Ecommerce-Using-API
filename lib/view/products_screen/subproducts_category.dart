import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_screen/sub_products_contrroller.dart';
import '../../routes/app_routes.dart';
import '../product_details/productdetails_screen.dart';
import '../widgets/common_appbar.dart';

class SubCategoryProductsScreen extends StatelessWidget {
  final String category;
  final SubProductsController controller = Get.put(SubProductsController());

  SubCategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    controller.fetchProducts(category);

    return Scaffold(
      appBar: CommonAppBar(
        title: category.capitalizeFirst!,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Get.toNamed(AppRoutes.cartPage);
            },
          ),
        ],
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              return _buildProductItem(controller.products[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsPage(productId: product['id']));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '₹${product['price']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                      Text('${product['rating']['rate']} (${product['rating']['count']} Reviews)',
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
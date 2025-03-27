import 'package:ecommerce_task/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_screen/cart_controller.dart';
import '../widgets/common_appbar.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'My Cart',
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(
        () => cartController.cartItems.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cartItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(item['image'],
                                      width: 70, height: 70, fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item['title'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 4),
                                      Text(item['category'],
                                          style: TextStyle(
                                              color: Colors.grey.shade600)),
                                      const SizedBox(height: 4),
                                      Text('₹${item['price']}',
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.redAccent,
                                            size: 18,
                                          ),
                                          onPressed: () => cartController
                                              .decreaseQuantity(item['id']),
                                        ),
                                        Text('${item['quantity']}',
                                            style:
                                                const TextStyle(fontSize: 16)),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                          onPressed: () => cartController
                                              .increaseQuantity(item['id']),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                      onPressed: () =>
                                          cartController.removeFromCart(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal:',
                                style: TextStyle(fontSize: 16)),
                            Obx(() => Text('₹${cartController.getSubtotal()}',
                                style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Obx(() => Text('₹${cartController.getTotal()}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade400,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => Get.toNamed(AppRoutes.checkoutPage),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
      ),
    );
  }
}
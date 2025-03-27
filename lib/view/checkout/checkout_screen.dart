import 'package:ecommerce_task/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_screen/cart_controller.dart';
import '../widgets/common_appbar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Place Your Order',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.orange)),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter your address',
                prefixIcon: Icon(Icons.location_on, color: Colors.orange.shade200),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: Colors.orange)),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              items: ['Credit Card', 'Debit Card', 'Cash on Delivery']
                  .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                  .toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.payment, color: Colors.orange.shade200),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  cartController.clearCart();
                  Get.snackbar(
                    'Order Placed',
                    'Your order has been placed successfully!',
                    backgroundColor: Colors.orange.withOpacity(0.8),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                    snackPosition: SnackPosition.TOP,
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.offAllNamed(AppRoutes.bottomNavigationPage);
                  });
                },
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                label: const Text('Place Order', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Safe & Secure Payment Guaranteed',
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}

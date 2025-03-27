import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  void addToCart(Map<String, dynamic> product) {
    int index = cartItems.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      cartItems[index]['quantity'] += 1;
    } else {
      product['quantity'] = 1;
      cartItems.add(product);
    }
    Get.snackbar('Success', '${product['title']} added to cart!', snackPosition: SnackPosition.BOTTOM);
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  void increaseQuantity(int productId) {
    int index = cartItems.indexWhere((item) => item['id'] == productId);
    if (index != -1) {
      cartItems[index]['quantity'] += 1;
      cartItems.refresh();
    }
  }
  double getSubtotal() {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double getTotal() {
    const double taxRate = 0.05;
    double subtotal = getSubtotal();
    double tax = subtotal * taxRate;
    return subtotal + tax;
  }

  void decreaseQuantity(int productId) {
    int index = cartItems.indexWhere((item) => item['id'] == productId);
    if (index != -1) {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity'] -= 1;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
    }
  }
  void clearCart() {
    cartItems.clear();
    Get.snackbar('Order Placed', 'Your order has been placed successfully.',
        snackPosition: SnackPosition.BOTTOM);
  }
}

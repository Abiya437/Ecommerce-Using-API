import 'package:ecommerce_task/routes/app_routes.dart';
import 'package:ecommerce_task/view/cart/cart_screen.dart';
import 'package:ecommerce_task/view/checkout/checkout_screen.dart';
import 'package:ecommerce_task/view/product_details/productdetails_screen.dart';
import 'package:ecommerce_task/view/products_screen/home_screen.dart';
import 'package:ecommerce_task/view/products_screen/subproducts_category.dart';
import 'package:ecommerce_task/view/widgets/bottom_navigation.dart';
import 'package:get/get.dart';

import '../view/category/category_screen.dart';

class AppPages {
  static final pages=[

    GetPage(name: AppRoutes.bottomNavigationPage, page:() => BottomNavigationScreen()),
    GetPage(name: AppRoutes.productPage, page:() => ProductsPage()),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => ProductDetailsPage(productId: Get.arguments['productId']),
    ),
    GetPage(name: AppRoutes.cartPage, page: ()=> CartScreen()),
    GetPage(name: AppRoutes.checkoutPage,page: ()=> CheckoutScreen()),
    GetPage(name: AppRoutes.categoryPage,page: ()=> CategoryScreen()),
    GetPage(name: AppRoutes.subCategoryProduct,page: ()=> SubCategoryProductsScreen(category: Get.arguments['category'])),

  ];
}



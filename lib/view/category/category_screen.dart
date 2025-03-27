import 'package:ecommerce_task/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product/product_controller.dart';
import '../widgets/common_appbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    categoryController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Categories',
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoryController.categories.isEmpty) {
          return const Center(child: Text('No Categories Found'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];
            return _buildCategoryItem(category);
          },
        );
      }),
    );
  }

  Widget _buildCategoryItem(String categoryName) {
    final imageMap = {
      'electronics': 'assets/Electronic.png',
      'jewelery': 'assets/jewellery.png',
      'men\'s clothing': 'assets/menscloth.png',
      'women\'s clothing': 'assets/womenscloth.png',
    };
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.subCategoryProduct, arguments: {'category': categoryName}),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 40,
              backgroundImage: AssetImage(imageMap[categoryName] ?? 'assets/default.png'),
            ),
            const SizedBox(height: 12),
            Text(
              categoryName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
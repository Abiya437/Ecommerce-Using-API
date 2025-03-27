import 'package:flutter/material.dart';
import '../../Model/all_products/all_products_model.dart';
import '../../controller/product/all_products.dart';
import '../../controller/product/product_controller.dart';
import '../widgets/slider.dart';
import 'package:get/get.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());

  final List<String> banners = [
    "assets/discount.png",
    "assets/discount.png",
    "assets/discount.png",
  ];

  @override
  void initState() {
    super.initState();
    productController.fetchProducts();
    categoryController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationHeader(),
              SizedBox(height: 7),
              _buildSearchBar(),
              SizedBox(height: 20),
              CarouselSliderWidget(imageUrls: banners),
              SizedBox(height: 20),


              Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Obx(() {
                if (categoryController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return _buildCategoryRow();
              }),

              SizedBox(height: 20),
              Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Obx(() {
                if (productController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return _buildProductGrid();
              }),
            ],
          ),
        ),
      ),


    );
  }

  Widget _buildLocationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.orange),
            SizedBox(width: 4),
            Text('Coimbatore, Tamil Nadu, India', style: TextStyle(color: Colors.black, fontSize: 14)),
          ],
        ),
        IconButton(
          icon: Icon(Icons.notifications_none_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search Product',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }


  Widget _buildCategoryRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryController.categories.map((cat) => _buildCategoryItem(cat)).toList(),
      ),
    );
  }

  Widget _buildCategoryItem(String name) {
    final imageMap = {
      'electronics': 'assets/Electronic.png',
      'jewelery': 'assets/jewellery.png',
      'men\'s clothing': 'assets/menscloth.png',
      'women\'s clothing': 'assets/womenscloth.png',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 30,
            backgroundImage: AssetImage(imageMap[name] ?? 'assets/default.png'),
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: productController.products.length,
      itemBuilder: (context, index) {
        final product = productController.products[index];
        return _buildProductItem(product);
      },
    );
  }

  Widget _buildProductItem(Product product) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14)),
          Text('\₹${product.price}', style: TextStyle(color: Colors.orangeAccent)),
        ],
      ),
    );
  }
}
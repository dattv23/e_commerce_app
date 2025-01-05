import 'package:e_commerce_app/components/product/product_card.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/product_service.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String slug;

  const CategoryProductsScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final products = productService.fetchProductsByCategory(slug);

    return Scaffold(
      appBar: AppBar(
        title: Text('Category: $slug'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          final productList = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio: 0.7, // Adjust the aspect ratio as needed
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ProductCard(
                  brandName: product.brandName,
                  discountPercent: product.discountPercent,
                  image: product.image,
                  press: () {
                    Navigator.pushNamed(context, '/products/${product.id}');
                  },
                  price: product.price,
                  title: product.title,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

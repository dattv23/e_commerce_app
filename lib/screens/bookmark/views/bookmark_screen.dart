import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/product/product_card.dart';
import 'package:e_commerce_app/models/product_model.dart';

import '../../../constants.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        future: productService.fetchPopularProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No popular products found.'),
            );
          } else {
            final popularProducts = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: 0.66,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final product = popularProducts[index];
                        return ProductCard(
                          image: product.image,
                          brandName: product.brandName,
                          title: product.title,
                          price: product.price,
                          discountPercent: product.discountPercent,
                          press: () {
                            Navigator.pushNamed(context,
                                '/products/${popularProducts[index].id}');
                          },
                        );
                      },
                      childCount: popularProducts.length,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

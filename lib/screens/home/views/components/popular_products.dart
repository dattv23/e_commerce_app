import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/product/product_card.dart';
import 'package:e_commerce_app/models/product_model.dart';

import '../../../../constants.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Popular products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // Fetch and display popular products
        FutureBuilder<List<ProductModel>>(
          future: productService.fetchPopularProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No popular products available.'),
              );
            } else {
              final popularProducts = snapshot.data!;
              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularProducts.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == popularProducts.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: ProductCard(
                      image: popularProducts[index].image,
                      brandName: popularProducts[index].brandName,
                      title: popularProducts[index].title,
                      price: popularProducts[index].price,
                      discountPercent: popularProducts[index].discountPercent,
                      press: () {
                        Navigator.pushNamed(
                            context, '/products/${popularProducts[index].id}');
                      },
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

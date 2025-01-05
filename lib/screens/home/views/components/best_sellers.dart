import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/product/product_card.dart';
import 'package:e_commerce_app/models/product_model.dart';

import '../../../../constants.dart';

class BestSellers extends StatelessWidget {
  const BestSellers({super.key});

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
            "Best sellers",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use FutureBuilder
        FutureBuilder<List<ProductModel>>(
          future: productService.fetchBestSellers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No best sellers found.'),
              );
            } else {
              final bestSellers = snapshot.data!;
              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSellers.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right:
                          index == bestSellers.length - 1 ? defaultPadding : 0,
                    ),
                    child: ProductCard(
                      image: bestSellers[index].image,
                      brandName: bestSellers[index].brandName,
                      title: bestSellers[index].title,
                      price: bestSellers[index].price,
                      discountPercent: bestSellers[index].discountPercent,
                      press: () {
                        Navigator.pushNamed(
                            context, '/products/${bestSellers[index].id}');
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

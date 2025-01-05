import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

import '/components/Banner/M/banner_m_with_counter.dart';
import '../../../../components/product/product_card.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading show Banner Skeleton if needed
        BannerMWithCounter(
          duration: const Duration(hours: 8),
          text: "Super Flash Sale \n50% Off",
          press: () {},
        ),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Flash sale",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading show Products Skeleton
        FutureBuilder<List<ProductModel>>(
          future: productService.fetchFlashSaleProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Flash Sale products available.'),
              );
            } else {
              final flashSaleProducts = snapshot.data!;
              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: flashSaleProducts.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == flashSaleProducts.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: ProductCard(
                      image: flashSaleProducts[index].image,
                      brandName: flashSaleProducts[index].brandName,
                      title: flashSaleProducts[index].title,
                      price: flashSaleProducts[index].price,
                      discountPercent: flashSaleProducts[index].discountPercent,
                      press: () {
                        Navigator.pushNamed(context,
                            '/products/${flashSaleProducts[index].id}');
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

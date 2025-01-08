import 'package:e_commerce_app/utils/calculateDiscountedPrice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/components/custom_modal_bottom_sheet.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/product_service.dart';

import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import '../../../components/review_card.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<ProductModel?> _productFuture;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    _productFuture = _productService.fetchProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<ProductModel?>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text('Product not found.'),
              );
            } else {
              final product = snapshot.data!;
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        floating: true,
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/icons/Bookmark.svg",
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                      ProductImages(
                        images: [product.image, product.image, product.image],
                      ),
                      ProductInfo(
                        brand: product.brandName,
                        title: product.title,
                        isAvailable: true,
                        description: 'No description',
                        rating: 4.3,
                        numOfReviews: 124,
                      ),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: ReviewCard(
                            rating: 4.3,
                            numOfReviews: 124,
                            numOfFiveStar: 65,
                            numOfFourStar: 12,
                            numOfThreeStar: 1,
                            numOfTwoStar: 3,
                            numOfOneStar: 5,
                          ),
                        ),
                      ),
                      ProductListTile(
                        svgSrc: "assets/icons/Chat.svg",
                        title: "Reviews",
                        isShowBottomBorder: true,
                        press: () {},
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 180),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CartButton(
                      price: product.discountPercent == 0
                          ? product.price
                          : calculateDiscountedPrice(
                              product.price, product.discountPercent),
                      press: () {
                        customModalBottomSheet(
                          context,
                          height: MediaQuery.of(context).size.height * 0.92,
                          child: ProductBuyNowScreen(product: product),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String image;
  final String brandName;
  final String title;
  final double price;
  final List<String> category;
  final int discountPercent;

  ProductModel({
    required this.id,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    required this.category,
    required this.discountPercent,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'brandName': brandName,
      'title': title,
      'price': price,
      'category': category,
      'discountPercent': discountPercent,
    };
  }

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ProductModel(
      id: doc.id,
      image: data['image'] ?? '',
      brandName: data['brandName'] ?? '',
      title: data['title'] ?? '',
      price: (data['price'] as num).toDouble(),
      category: List<String>.from(data['category'] ?? []),
      discountPercent: data['discountPercent'],
    );
  }
}

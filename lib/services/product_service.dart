import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchPopularProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('isPopular', isEqualTo: true) // Adjust field as needed
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching popular products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchBestSellers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('isBestSeller', isEqualTo: true) // Adjust field as needed
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching best sellers: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchFlashSaleProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('isFlashSale', isEqualTo: true) // Adjust field as needed
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching Flash Sale products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String slug) async {
    try {
      // Query Firestore for products where the category array contains the given slug
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('category', arrayContains: slug)
          .get();

      // Map the Firestore documents to ProductModel instances
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }

  Future<ProductModel?> fetchProductById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('products').doc(id).get();
      if (doc.exists) {
        return ProductModel.fromFirestore(doc);
      } else {
        print('Product with id $id not found.');
        return null; // Return null if the product doesn't exist
      }
    } catch (e) {
      print('Error fetching product by ID: $e');
      return null; // Return null in case of an error
    }
  }
}

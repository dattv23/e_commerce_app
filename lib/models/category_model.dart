import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String slug;
  final String title;
  final String? image;
  final String? svgSrc;
  final List<CategoryModel>? subCategories;

  CategoryModel({
    required this.slug,
    required this.title,
    this.image,
    this.svgSrc,
    this.subCategories,
  });

  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'title': title,
      'image': image,
      'svgSrc': svgSrc,
      'subCategories':
          subCategories?.map((category) => category.toMap()).toList(),
    };
  }

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List<CategoryModel>? subCats;

    if (data['subCategories'] != null) {
      subCats = (data['subCategories'] as List).map((subCat) {
        return CategoryModel(
          slug: subCat['slug'] ?? '',
          title: subCat['title'] ?? '',
          image: subCat['image'],
          svgSrc: subCat['svgSrc'],
        );
      }).toList();
    }

    return CategoryModel(
      slug: data['slug'] ?? '',
      title: data['title'] ?? '',
      image: data['image'],
      svgSrc: data['svgSrc'],
      subCategories: subCats,
    );
  }
}

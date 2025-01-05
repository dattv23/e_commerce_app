import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/services/category_service.dart';
import 'package:e_commerce_app/screens/search/views/components/search_form.dart';
import 'components/discover_categories_skeleton.dart';
import 'components/expansion_category.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final categories = await _categoryService.getCategories();

      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: SearchForm(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  if (_error != null)
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _fetchCategories,
                    ),
                ],
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const DiscoverCategoriesSkeleton();
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: defaultPadding),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (_categories.isEmpty) {
      return const Center(
        child: Text('No categories found'),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchCategories,
      child: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) => ExpansionCategory(
          svgSrc: _categories[index].svgSrc ?? '',
          slug: _categories[index].slug,
          title: _categories[index].title,
          subCategory: _categories[index].subCategories ?? [],
        ),
      ),
    );
  }
}

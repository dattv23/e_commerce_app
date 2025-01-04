import 'package:e_commerce_app/screens/search/views/components/search_form.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _searchQuery;

  void _onSearchChanged(String? value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _onSearchSubmitted(String? value) {
    // Handle search submission (e.g., trigger API call)
    print("Search submitted: $value");
  }

  void _onSearchSaved(String? value) {
    setState(() {
      _searchQuery = value;
    });
    print("Search saved: $value");
  }

  void _onFilterTapped() {
    // Open filter options (e.g., show a bottom sheet or navigate to a filter screen)
    print("Filter button tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SearchForm(
          formKey: _formKey,
          onChanged: _onSearchChanged,
          onFieldSubmitted: _onSearchSubmitted,
          onSaved: _onSearchSaved,
          onTabFilter: _onFilterTapped,
        ),
      ),
    );
  }
}

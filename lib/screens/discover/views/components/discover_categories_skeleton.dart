import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class DiscoverCategoriesSkeleton extends StatelessWidget {
  const DiscoverCategoriesSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(defaultBorderRadious),
          ),
        ),
      ),
    );
  }
}

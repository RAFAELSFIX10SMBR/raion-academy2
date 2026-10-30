import 'package:flutter/material.dart';

import '../models/category_data.dart';

/// Kotak ikon dengan nama di bawahnya (dipakai 4 kali di Home).
class CategoryItem extends StatelessWidget {
  final CategoryData category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(category.icon, color: category.color),
        ),
        const SizedBox(height: 6),
        Text(category.name, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

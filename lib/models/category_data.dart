import 'package:flutter/material.dart';

/// Bentuk data satu kategori (tanpa tampilan).
class CategoryData {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryData(this.name, this.icon, this.color);
}

const List<CategoryData> categories = [
  CategoryData('Makan', Icons.restaurant, Color(0xFFF57C00)),
  CategoryData('Transport', Icons.two_wheeler, Color(0xFF00897B)),
  CategoryData('Kuliah', Icons.school, Color(0xFF6D4C41)),
  CategoryData('Lainnya', Icons.more_horiz, Color(0xFF757575)),
];

import 'category_data.dart';

/// Bentuk data satu pengeluaran.
class Expense {
  final String id; // pembeda tiap pengeluaran (dipakai saat hapus)
  final CategoryData category;
  final String title;
  final DateTime time;
  final int amount; // disimpan sebagai angka supaya bisa dijumlahkan

  const Expense({
    required this.id,
    required this.category,
    required this.title,
    required this.time,
    required this.amount,
  });
}

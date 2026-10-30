import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category_data.dart';
import '../models/expense.dart';

/// Saldo awal. Sisa saldo = saldo awal - total pengeluaran.
const int startingBalance = 290000;

class ExpenseNotifier extends Notifier<List<Expense>> {
  // build() = data awal
  @override
  List<Expense> build() {
    DateTime today(int hour, int minute) {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    }

    return [
      Expense(
        id: 'e1',
        category: categories[0],
        title: 'Nasi goreng',
        time: today(7, 30),
        amount: 15000,
      ),
      Expense(
        id: 'e2',
        category: categories[1],
        title: 'Ojek ke kampus',
        time: today(8, 10),
        amount: 12000,
      ),
      Expense(
        id: 'e3',
        category: categories[2],
        title: 'Print tugas',
        time: today(10, 45),
        amount: 3000,
      ),
      Expense(
        id: 'e4',
        category: categories[0],
        title: 'Es teh',
        time: today(12, 15),
        amount: 5000,
      ),
    ];
  }

  /// Tambah pengeluaran baru di urutan paling atas.
  void add({
    required CategoryData category,
    required String note,
    required int amount,
  }) {
    final expense = Expense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      category: category,
      // kalau catatan kosong, pakai nama kategori sebagai judul
      title: note.isEmpty ? category.name : note,
      time: DateTime.now(),
      amount: amount,
    );
    // state diganti list BARU supaya Riverpod tahu ada perubahan
    state = [expense, ...state];
  }

  /// Hapus pengeluaran -> saldo otomatis balik lagi.
  void remove(String id) {
    state = state.where((expense) => expense.id != id).toList();
  }
}

final expenseProvider =
    NotifierProvider<ExpenseNotifier, List<Expense>>(ExpenseNotifier.new);

/// Sisa saldo DIHITUNG dari riwayat, bukan ditulis manual.
final balanceProvider = Provider<int>((ref) {
  final expenses = ref.watch(expenseProvider);
  final total = expenses.fold<int>(0, (sum, e) => sum + e.amount);
  return startingBalance - total;
});

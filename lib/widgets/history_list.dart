import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/expense_provider.dart';
import '../theme/app_colors.dart';
import 'history_item.dart';

/// Kotak riwayat. Data dibaca dari provider, jadi otomatis ikut berubah.
class HistoryList extends ConsumerWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseProvider);

    if (expenses.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Belum ada pengeluaran',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textGrey),
        ),
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int i = 0; i < expenses.length; i++) ...[
            // Geser ke kiri untuk menghapus
            Dismissible(
              key: ValueKey(expenses[i].id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red.shade400,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                ref.read(expenseProvider.notifier).remove(expenses[i].id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengeluaran dihapus')),
                );
              },
              child: HistoryItem(expense: expenses[i]),
            ),
            if (i != expenses.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

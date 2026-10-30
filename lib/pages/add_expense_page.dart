import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category_data.dart';
import '../providers/expense_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/category_chip.dart';

// ConsumerStatefulWidget: butuh controller (baca isi TextField) + akses provider
class AddExpensePage extends ConsumerStatefulWidget {
  const AddExpensePage({super.key});

  @override
  ConsumerState<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<AddExpensePage> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  int _selectedIndex = 0; // kategori yang sedang terpilih

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _save() {
    final amount = int.tryParse(_amountController.text);

    // nominal kosong / 0 -> jangan disimpan
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi nominalnya dulu ya')),
      );
      return;
    }

    // read: panggil fungsi sekali saja
    ref.read(expenseProvider.notifier).add(
          category: categories[_selectedIndex],
          note: _noteController.text.trim(),
          amount: amount,
        );

    Navigator.pop(context); // balik ke Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pengeluaran')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Nominal -----
            const Text(
              'Nominal',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            Row(
              children: [
                const Text(
                  'Rp',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(hintText: '0'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ----- Pilihan kategori -----
            const Text(
              'Kategori',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int i = 0; i < categories.length; i++)
                  CategoryChip(
                    category: categories[i],
                    selected: _selectedIndex == i,
                    onTap: () => setState(() => _selectedIndex = i),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // ----- Catatan (3 baris) -----
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Catatan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // ----- Tombol Simpan -----
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

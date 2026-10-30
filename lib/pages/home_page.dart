import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category_data.dart';
import '../providers/expense_provider.dart';
import '../utils/format.dart';
import '../widgets/balance_card.dart';
import '../widgets/category_item.dart';
import '../widgets/history_list.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_title.dart';
import 'add_expense_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch: kalau saldo berubah, build() jalan lagi
    final balance = ref.watch(balanceProvider);

    // Tanpa AppBar: bagian paling atas langsung header
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(name: 'Rafael'),
              const SizedBox(height: 20),
              BalanceCard(
                balance: formatRupiah(balance),
                onCatat: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddExpensePage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              const SectionTitle(title: 'Kategori'),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: categories
                    .map((c) => CategoryItem(category: c))
                    .toList(),
              ),
              const SizedBox(height: 24),
              const SectionTitle(title: 'Riwayat', trailing: 'Geser kiri = hapus'),
              const SizedBox(height: 12),
              const HistoryList(),
            ],
          ),
        ),
      ),
    );
  }
}

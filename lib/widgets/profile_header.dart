import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;

  const ProfileHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Foto dari folder assets (bukan internet)
        ClipOval(
          child: Image.asset(
            'assets/images/profile.png',
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            // cadangan kalau file belum ada, supaya tidak error merah
            errorBuilder: (context, error, stackTrace) => Container(
              width: 44,
              height: 44,
              color: AppColors.primaryLight,
              child: const Icon(Icons.person, color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat pagi,',
                style: TextStyle(fontSize: 12, color: AppColors.textGrey),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.notifications_none),
      ],
    );
  }
}

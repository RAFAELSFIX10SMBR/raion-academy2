/// 15000 -> "Rp15.000"
String formatRupiah(int value) {
  final digits = value.abs().toString();
  final withDots = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
  return '${value < 0 ? '-' : ''}Rp$withDots';
}

/// DateTime -> "07.30"
String formatTime(DateTime time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour.$minute';
}

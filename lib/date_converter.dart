import 'package:intl/intl.dart';

String dateToStringLengkap(DateTime date) {
  return DateFormat('EEEE, d MMMM yyyy, HH:mm', 'id_ID').format(date);
}

String remainingTime(DateTime date, {int tenggatInHour = 3}) {
  DateTime maxTime = date.add(Duration(hours: tenggatInHour));

  // Hitung waktu tersisa dari waktu maksimal
  Duration remainingDuration = maxTime.difference(DateTime.now());

  // Pastikan bahwa durasi tersisa tidak negatif
  if (remainingDuration.isNegative) {
    remainingDuration = Duration
        .zero; // Jika sudah lewat dari 3 jam, set waktu tersisa menjadi 0
  }

  int hours = remainingDuration.inHours;
  int minutes = remainingDuration.inMinutes.remainder(60);

  // Format hasil ke dalam string
  String remainingTime = '$hours jam $minutes menit tersisa';

  return remainingTime;
}

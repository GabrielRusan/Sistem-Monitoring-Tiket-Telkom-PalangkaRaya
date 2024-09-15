import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/presentations/blocs/all_tiket_bloc/all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/utils/style.dart'; // Ganti dengan style Anda

class _BarChart extends StatelessWidget {
  final List<Tiket> tickets;
  const _BarChart(this.tickets);

  @override
  Widget build(BuildContext context) {
    final ticketCountMap = getTicketsCountPerDay(tickets);
    final barGroups = generateBarGroups(ticketCountMap);
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: getMaxY(), // Mengatur maxY berdasarkan data
      ),
    );
  }

  // Fungsi untuk mendapatkan nama hari-hari dalam seminggu
  List<String> getDaysOfWeek() {
    final now = DateTime.now();
    final days = <String>[];

    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: i)); // Mengambil hari sebelumnya
      days.add(getShortDayName(day.weekday)); // Mendapatkan singkatan nama hari
    }

    return days.reversed.toList(); // Reverse agar hari ini paling kanan
  }

  // Fungsi untuk mendapatkan singkatan nama hari
  String getShortDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Senin';
      case DateTime.tuesday:
        return 'Selasa';
      case DateTime.wednesday:
        return 'Rabu';
      case DateTime.thursday:
        return 'Kamis';
      case DateTime.friday:
        return 'Jumat';
      case DateTime.saturday:
        return 'Sabtu';
      case DateTime.sunday:
        return 'Minggu';
      default:
        return '';
    }
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: active,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final daysOfWeek = getDaysOfWeek(); // Ambil hari-hari yang sudah diatur

    // Pastikan index sesuai dengan jumlah bar chart
    if (value.toInt() < daysOfWeek.length) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text(daysOfWeek[value.toInt()], style: style),
      );
    } else {
      return Container();
    }
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  // Fungsi untuk mendapatkan nilai maxY berdasarkan data terbesar
  double getMaxY() {
    double maxY = 0;
    for (final group in barGroups) {
      for (final rod in group.barRods) {
        if (rod.toY > maxY) {
          maxY = rod.toY;
        }
      }
    }
    return maxY + 28; // Menambahkan sedikit margin di atas bar terbesar
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: lightActive,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          active,
          lightActive,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2), // Mengatur radius bar
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 40,
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 13,
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2),
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  Map<String, int> getTicketsCountPerDay(List<Tiket> tickets) {
    final now = DateTime.now();
    final Map<String, int> ticketCountMap = {};

    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: i));
      final dayString = "${day.year}-${day.month}-${day.day}";

      ticketCountMap[dayString] = tickets.where((ticket) {
        final createdAt = ticket.createdAt;
        return createdAt.year == day.year &&
            createdAt.month == day.month &&
            createdAt.day == day.day;
      }).length;
    }

    return ticketCountMap;
  }

  List<BarChartGroupData> generateBarGroups(Map<String, int> ticketCountMap) {
    final List<BarChartGroupData> groups = [];
    int index = 0;

    ticketCountMap.forEach((day, count) {
      groups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              gradient: _barsGradient,
              width: 28,
              borderRadius: BorderRadius.circular(2),
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
      index++;
    });

    return groups;
  }
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BlocBuilder<AllTiketBloc, AllTiketState>(
        builder: (context, state) {
          return _BarChart(state.result);
        },
      ),
    );
  }
}

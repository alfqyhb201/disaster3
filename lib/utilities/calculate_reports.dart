import 'package:disaster/models/sales_data.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/reports_model.dart';
import '../services/database_services.dart';

class CalculateReports {
  double dailyTotal(List<Reports>? reports) {
    double totalIncome = 0.0;
    var values = reports!.map((e) => double.parse(e.price));
    totalIncome = values.fold(0, (a, b) => a + b);
    return totalIncome;
  }

  Future<double> summarizeTotal(int day) async {
    double total = 0.0;
    var d = await DatabaseServices.getDailyReports(day);
    if (d != null) {
      total = dailyTotal(d);
    }
    if (kDebugMode) {
      print('total = $total');
    }
    return total;
  }

  summarizeMonthsTotal(bool isThisMonth) async {
    int thisMonth =
        isThisMonth ? DateTime.now().month : DateTime.now().month - 1;
    List<Reports>? reports = await DatabaseServices.getReports();
    List<Reports> repo = [];
    if (reports != null) {
      for (var lis in reports) {
        final date = DateFormat('y/M/d').parse(lis.date).month;
        if (date == thisMonth) {
          repo.add(lis);
        }
      }
      return dailyTotal(repo);
    }
    return 0.0;
  }

  Future<List<SalesData>> summarizeCharts() async {
    List<SalesData> chartTotal = [];
    List<Reports>? reports = await DatabaseServices.getReports();
    final dateNow = DateTime.now();
    if (reports != null) {
      for (int i = 1; i <= 12; i++) {
        List<SalesData> salesData = [];
        for (var lis in reports) {
          final date = DateFormat('y/M/d').parse(lis.date);
          if (date.year == dateNow.year && date.month == i) {
            salesData.add(SalesData(i, double.parse(lis.price)));
          }
        }
        if (salesData.isNotEmpty) {
          double totalIncome = 0.0;
          var values = salesData.map((e) => e.sales);
          totalIncome = values.fold(0, (a, b) => a + b);
          chartTotal.add(SalesData(i, totalIncome));
        } else {
          chartTotal.add(SalesData(i, 0.0));
        }
      }
    }

    return chartTotal;
  }

  Future<List<Reports>> filteredReportTable(DateTime dateTime) async {
    List<Reports>? reports = await DatabaseServices.getReports();
    List<Reports> newReports = [];
    final selectedDate = DateFormat('yyyy/MM/dd').format(dateTime);
    if (reports != null) {
      for (var report in reports) {
        // final dd = DateTime.parse(report.date);
        final dataDate = DateFormat('yyyy/MM/dd').parse(report.date).toString();

        final DateTime date = DateTime.parse(dataDate);
        final DateFormat formatter = DateFormat('yyyy/MM/dd');
        final String formatted = formatter.format(date);
        // print('dataDate: $dataDate');
        if (selectedDate == formatted) {
          // print('dataDate: $formatted');
          // print('selectedDate: $selectedDate');
          newReports.add(report);
        }
      }
    }

    return newReports;
  }
}

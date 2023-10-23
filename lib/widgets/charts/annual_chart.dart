import 'dart:math';

import 'package:disaster/utilities/calculate_reports.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/sales_data.dart';

class AnnualChart extends StatefulWidget {
  const AnnualChart({Key? key}) : super(key: key);

  @override
  State<AnnualChart> createState() => _AnnualChartState();
}

class _AnnualChartState extends State<AnnualChart> {
  List<SalesData> salesData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        await CalculateReports().summarizeCharts().then((value) {
          setState(() {
            salesData = value;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100.0,
        height: 500.0,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: blackColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: blackColor,
                offset: const Offset(5, 5),
                blurRadius: 10.0,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: whiteColor,
                offset: const Offset(-5, -5),
                blurRadius: 10.0,
                spreadRadius: 5,
              ),
            ],
          ),
          child: BarChart(
            BarChartData(
              backgroundColor: blackColor,
              borderData: FlBorderData(show: false),
              alignment: BarChartAlignment.start,
              gridData:
                  FlGridData(drawHorizontalLine: true, horizontalInterval: 30),
              maxY: 300,
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 80,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value == 0) {
                        return const Text('0');
                      } else if (value == 50) {
                        return const Text('50k');
                      } else if (value == 100) {
                        return const Text('100k');
                      } else if (value == 150) {
                        return const Text('150k');
                      } else if (value == 200) {
                        return const Text('200k');
                      } else if (value == 250) {
                        return const Text('250k');
                      } else if (value == 300) {
                        return const Text('300k');
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value == 12) {
                        return const Text('DEC');
                      } else if (value == 1) {
                        return const Text('JAN');
                      } else if (value == 2) {
                        return const Text('FEB');
                      } else if (value == 3) {
                        return const Text('MAR');
                      } else if (value == 4) {
                        return const Text('APR');
                      } else if (value == 5) {
                        return const Text('MAY');
                      } else if (value == 6) {
                        return const Text('JUN');
                      } else if (value == 7) {
                        return const Text('JUL');
                      } else if (value == 8) {
                        return const Text('AUG');
                      } else if (value == 9) {
                        return const Text('SEP');
                      } else if (value == 10) {
                        return const Text('OCT');
                      } else if (value == 11) {
                        return const Text('NOV');
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                ),
              ),
              baselineY: 100.0,
              barTouchData: BarTouchData(
                enabled: true,
                allowTouchBarBackDraw: true,
                handleBuiltInTouches: true,
                touchTooltipData: BarTouchTooltipData(
                  // maxContentWidth: 60.0,
                  tooltipBgColor: blueColor,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${(rod.toY * 1000)} ريال',
                      const TextStyle(color: Colors.white),
                      textDirection: TextDirection.rtl,
                    );
                  },
                ),
              ),
              barGroups: [
                ...List.generate(12, (index) {
                  if (salesData.isNotEmpty) {
                    var saleData = salesData[index];
                    return BarChartGroupData(
                      x: saleData.month,
                      barRods: [
                        BarChartRodData(
                          fromY: 0,
                          toY: saleData.sales / 1000,
                          color: Colors.primaries.elementAt(
                              Random().nextInt(Colors.primaries.length)),
                          borderRadius: BorderRadius.circular(5),
                          width: 60,
                        ),
                      ],
                    );
                  } else {
                    return BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          fromY: 0,
                          toY: 0,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          width: 40,
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
            swapAnimationDuration:
                const Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
      ),
    );
  }
}

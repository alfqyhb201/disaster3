import 'package:clay_containers/clay_containers.dart';
import 'package:disaster/utilities/calculate_reports.dart';
import 'package:flutter/material.dart';

import '../../models/reports_model.dart';
import '../../services/database_services.dart';
import '../../utilities/colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/table_cells/my_colored_table_cell.dart';

class DailyReportPage extends StatefulWidget {
  const DailyReportPage({Key? key}) : super(key: key);

  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  @override
  Widget build(BuildContext context) {
    Widget fBuilder() {
      return FutureBuilder(
        future: DatabaseServices.getDailyReports(0),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ClayContainer(
              width: 400.0,
              height: 300.0,
              depth: 50,
              borderRadius: 20.0,
              curveType: CurveType.convex,
              spread: 5.0,
              surfaceColor: Colors.white,
              // emboss: true,
              parentColor: blueColor,
              child: Center(
                  child: Text(
                'لا يوجد',
                style: TextStyle(color: blackColor, fontSize: 30.0),
              )),
            );
          }
          List<Reports>? reports = snapshot.data;

          double totalIncome = CalculateReports().dailyTotal(reports!);
          // double totalIncome = 0.0;
          // var values = reports!.map((e) => double.parse(e.price));
          // totalIncome = values.fold(0, (a, b) => a + b);
          return Table(
            // border: TableBorder.all(color: blackColor, width: 0.5),
            textDirection: TextDirection.rtl,
            defaultVerticalAlignment: TableCellVerticalAlignment.fill,
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                children: [
                  MyColoredTableCell(
                    txt: '',
                    txtColor: whiteColor,
                  ),
                  MyColoredTableCell(
                    txt: 'الجهاز',
                    txtColor: whiteColor,
                  ),
                  MyColoredTableCell(
                    txt: 'المبلغ',
                    txtColor: whiteColor,
                  ),
                  MyColoredTableCell(
                    txt: 'المستخدم',
                    txtColor: whiteColor,
                  ),
                  MyColoredTableCell(
                    txt: 'التاريخ',
                    txtColor: whiteColor,
                  ),
                ],
              ),
              ...List.generate(reports.length, (index) {
                return TableRow(
                  children: [
                    const MyColoredTableCell(txt: '', isEmpty: true),
                    // MyColoredTableCell(txt: reports[index].id.toString()),
                    MyColoredTableCell(txt: reports[index].device),
                    MyColoredTableCell(txt: reports[index].price),
                    MyColoredTableCell(txt: reports[index].user),
                    MyColoredTableCell(
                      txt: reports[index].date,
                      txtDirection: false,
                    ),
                  ],
                );
              }),
              TableRow(
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                children: [
                  const MyColoredTableCell(txt: ''),
                  MyColoredTableCell(
                    txt: 'الاجمالي',
                    txtColor: whiteColor,
                  ),
                  MyColoredTableCell(
                    txt: totalIncome.toString(),
                    txtColor: whiteColor,
                  ),

                  // CustomTableCell(txt: totalIncome.toString()),
                  const MyColoredTableCell(txt: ''),
                  const MyColoredTableCell(txt: ''),
                ],
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: customAppBar(true),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'التقرير اليومي',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: fBuilder(),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

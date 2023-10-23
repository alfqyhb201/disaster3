import 'package:disaster/utilities/calculate_reports.dart';
import 'package:disaster/widgets/cards/report_text_span.dart';
import 'package:disaster/widgets/charts/annual_chart.dart';
import 'package:disaster/widgets/filter_report_widget.dart';
import 'package:flutter/material.dart';

import '../../utilities/colors.dart';
import '../../widgets/app_bar.dart';

class AnnualReportPage extends StatefulWidget {
  const AnnualReportPage({Key? key}) : super(key: key);

  @override
  State<AnnualReportPage> createState() => _AnnualReportPageState();
}

class _AnnualReportPageState extends State<AnnualReportPage> {
  int day = 1;
  double dayTotal = 0.0;
  double yesterdayTotal = 0.0;
  double thisMonthTotal = 0.0;
  double lastMonthTotal = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        calculateTotals();
      },
    );
  }

  calculateTotals() {
    CalculateReports().summarizeTotal(0).then((value) {
      setState(() {
        dayTotal = value;
      });
    });

    CalculateReports().summarizeTotal(1).then((value) {
      setState(() {
        yesterdayTotal = value;
      });
    });
    CalculateReports().summarizeMonthsTotal(true).then((value) {
      setState(() {
        thisMonthTotal = value;
      });
    });
    CalculateReports().summarizeMonthsTotal(false).then((value) {
      setState(() {
        lastMonthTotal = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget fBuilder() {
    //   return FutureBuilder(
    //     future: DatabaseServices.getAllReports(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Center(
    //           child: ClayContainer(
    //             width: 400.0,
    //             height: 300.0,
    //             depth: 50,
    //             borderRadius: 20.0,
    //             curveType: CurveType.convex,
    //             spread: 5.0,
    //             emboss: true,
    //             surfaceColor: Colors.white,
    //             // emboss: true,
    //             parentColor: blueColor,
    //             child: Center(
    //                 child: Text(
    //               'لا يوجد',
    //               style: TextStyle(color: blackColor, fontSize: 30.0),
    //             )),
    //           ),
    //         );
    //       }
    //       List<Reports>? reports = snapshot.data;
    //       double totalIncome = CalculateReports().dailyTotal(reports!);
    //       // double totalIncome = 0.0;
    //       // var values = reports!.map((e) => double.parse(e.price));
    //       // totalIncome = values.fold(0, (a, b) => a + b);
    //
    //       List<TableRow> tableRow = [];
    //       List.generate(reports.length, (index) {
    //         int recordDay =
    //             DateTimeFunctions().getDateInMonth(reports[index].date);
    //         int d = day;
    //         if (recordDay == d) {
    //           return tableRow.add(
    //             TableRow(
    //               children: [
    //                 const MyColoredTableCell(txt: '', isEmpty: true),
    //                 // MyColoredTableCell(txt: reports[index].id.toString()),
    //                 MyColoredTableCell(txt: reports[index].device),
    //                 MyColoredTableCell(txt: reports[index].price),
    //                 MyColoredTableCell(txt: reports[index].user),
    //                 MyColoredTableCell(
    //                   txt: reports[index].date,
    //                   txtDirection: false,
    //                 ),
    //               ],
    //             ),
    //           );
    //         } else {
    //           day = recordDay;
    //
    //           tableRow.add(
    //             TableRow(
    //               decoration: BoxDecoration(
    //                 color: greenColor.withOpacity(0.5),
    //                 borderRadius: BorderRadius.circular(50.0),
    //               ),
    //               children: [
    //                 const MyColoredTableCell(txt: ''),
    //                 const MyColoredTableCell(txt: ''),
    //                 MyColoredTableCell(
    //                   txt: reports[index].date,
    //                   txtDirection: false,
    //                 ),
    //                 const MyColoredTableCell(txt: ''),
    //                 const MyColoredTableCell(txt: ''),
    //                 // MyColoredTableCell(txt: reports[index].price),
    //                 // MyColoredTableCell(txt: reports[index].user),
    //                 // MyColoredTableCell(
    //                 //   txt: reports[index].date,
    //                 //   txtDirection: false,
    //                 // ),
    //               ],
    //             ),
    //           );
    //           tableRow.add(
    //             TableRow(
    //               children: [
    //                 const MyColoredTableCell(txt: '', isEmpty: true),
    //                 MyColoredTableCell(txt: reports[index].device),
    //                 MyColoredTableCell(txt: reports[index].price),
    //                 MyColoredTableCell(txt: reports[index].user),
    //                 MyColoredTableCell(
    //                   txt: reports[index].date,
    //                   txtDirection: false,
    //                 ),
    //               ],
    //             ),
    //           );
    //         }
    //       });
    //       return Table(
    //         // border: TableBorder.all(color: blackColor, width: 0.5),
    //         textDirection: TextDirection.rtl,
    //         defaultVerticalAlignment: TableCellVerticalAlignment.fill,
    //         children: [
    //           TableRow(
    //             decoration: BoxDecoration(
    //               color: blueColor,
    //               borderRadius: BorderRadius.circular(50.0),
    //             ),
    //             children: [
    //               MyColoredTableCell(
    //                 txt: '',
    //                 txtColor: whiteColor,
    //               ),
    //               MyColoredTableCell(
    //                 txt: 'الجهاز',
    //                 txtColor: whiteColor,
    //               ),
    //               MyColoredTableCell(
    //                 txt: 'المبلغ',
    //                 txtColor: whiteColor,
    //               ),
    //               MyColoredTableCell(
    //                 txt: 'المستخدم',
    //                 txtColor: whiteColor,
    //               ),
    //               MyColoredTableCell(
    //                 txt: 'التاريخ',
    //                 txtColor: whiteColor,
    //               ),
    //             ],
    //           ),
    //           ...List.generate(tableRow.length, (index) => tableRow[index]),
    //           // ...List.generate(reports.length, (index) {
    //           //   int recordDay =
    //           //       DateTimeFunctions().getDateInMonth(reports[index].date);
    //           //   int d = day;
    //           //   if (recordDay == d) {
    //           //     return TableRow(
    //           //       children: [
    //           //         const MyColoredTableCell(txt: '', isEmpty: true),
    //           //         // MyColoredTableCell(txt: reports[index].id.toString()),
    //           //         MyColoredTableCell(txt: reports[index].device),
    //           //         MyColoredTableCell(txt: reports[index].price),
    //           //         MyColoredTableCell(txt: reports[index].user),
    //           //         MyColoredTableCell(
    //           //           txt: reports[index].date,
    //           //           txtDirection: false,
    //           //         ),
    //           //       ],
    //           //     );
    //           //   } else {
    //           //     day = recordDay;
    //           //     // return List.generate(2, (index) => TableRow()).toList();
    //           //     return TableRow(
    //           //       children: [
    //           //         const MyColoredTableCell(txt: '', isEmpty: true),
    //           //         MyColoredTableCell(
    //           //             txt: reports[index].device, txtColor: redColor),
    //           //         MyColoredTableCell(txt: reports[index].price),
    //           //         MyColoredTableCell(txt: reports[index].user),
    //           //         MyColoredTableCell(
    //           //           txt: reports[index].date,
    //           //           txtDirection: false,
    //           //         ),
    //           //       ],
    //           //     );
    //           //   }
    //           // }),
    //           TableRow(
    //             decoration: BoxDecoration(
    //               color: blueColor,
    //             ),
    //             children: [
    //               const MyColoredTableCell(txt: ''),
    //               MyColoredTableCell(
    //                 txt: 'الاجمالي',
    //                 txtColor: whiteColor,
    //               ),
    //               MyColoredTableCell(
    //                 txt: totalIncome.toString(),
    //                 txtColor: whiteColor,
    //               ),
    //
    //               // CustomTableCell(txt: totalIncome.toString()),
    //               const MyColoredTableCell(txt: ''),
    //               const MyColoredTableCell(txt: ''),
    //             ],
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

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
                  'التقرير السنوي',
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
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 100.0,
                  height: 300.0,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'إجمالي الأرباح المقدرة',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ReportTextSpan(
                                  title: 'دخل اليوم',
                                  price: dayTotal.toString()),
                              ReportTextSpan(
                                  title: 'دخل أمس',
                                  price: yesterdayTotal.toString()),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ReportTextSpan(
                                  title: 'هذا الشهر',
                                  price: thisMonthTotal.toString()),
                              ReportTextSpan(
                                  title: 'الشهر السابق',
                                  price: lastMonthTotal.toString()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const AnnualChart(),
              const SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width - 100,
                  child: const FilterReportWidget(),
                  // child: fBuilder(),
                ),
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

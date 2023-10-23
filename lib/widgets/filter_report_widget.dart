import 'package:disaster/utilities/calculate_reports.dart';
import 'package:flutter/material.dart';

import '../models/reports_model.dart';
import '../utilities/colors.dart';
import '../utilities/date_format_functions.dart';
import 'table_cells/my_colored_table_cell.dart';

class FilterReportWidget extends StatefulWidget {
  const FilterReportWidget({Key? key}) : super(key: key);

  @override
  State<FilterReportWidget> createState() => _FilterReportWidgetState();
}

class _FilterReportWidgetState extends State<FilterReportWidget> {
  List<Reports> reports = [];
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        await CalculateReports().filteredReportTable(dateTime).then((value) {
          setState(() {
            reports = value;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500.0,
      decoration: BoxDecoration(
        // color: blackColor,
        color: Colors.amber,
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // const SizedBox(
          //   height: 20.0,
          // ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.orange,
              boxShadow: [
                BoxShadow(
                  color: blackColor,
                  offset: const Offset(5, 5),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
              child: MaterialButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: dateTime,
                    firstDate: DateTime(2023),
                    lastDate: DateTime.now(),
                  ).then((value) async {
                    if (value != null) {
                      setState(() {
                        dateTime = value;
                      });
                      await CalculateReports()
                          .filteredReportTable(value)
                          .then((value) {
                        setState(() {
                          reports = value;
                        });
                      });
                    }
                  });
                },
                color: purpleColor,
                height: 50.0,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                    '${dateTime.year}/${dateTime.month}/${dateTime.day} | ${DateTimeFunctions().convertDateToDay(dateTime)}'),
              ),
            ),
          ),
          Table(
            textDirection: TextDirection.rtl,
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: blueColor,
                  // borderRadius: BorderRadius.circular(50.0),
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
            ],
          ),
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              child: Container(
                color: reports.isNotEmpty ? blackColor : Colors.transparent,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  textDirection: TextDirection.rtl,
                  defaultVerticalAlignment: TableCellVerticalAlignment.fill,
                  children: [
                    ...List.generate(reports.length, (index) {
                      return TableRow(
                        children: [
                          const MyColoredTableCell(txt: '', isEmpty: true),
                          // MyColoredTableCell(txt: reports[index].id.toString()),
                          MyColoredTableCell(
                            txt: reports[index].device,
                            txtColor: whiteColor,
                          ),
                          MyColoredTableCell(
                            txt: reports[index].price,
                            txtColor: whiteColor,
                          ),
                          MyColoredTableCell(
                            txt: reports[index].user,
                            txtColor: whiteColor,
                          ),
                          MyColoredTableCell(
                            txt: reports[index].date,
                            txtDirection: false,
                            txtColor: whiteColor,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Table(
            textDirection: TextDirection.rtl,
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: blueColor,
                ),
                children: [
                  const MyColoredTableCell(txt: ''),
                  MyColoredTableCell(
                    txt: 'الاجمالي',
                    txtColor: whiteColor,
                  ),
                  MyColoredTableCell(
                    txt: CalculateReports().dailyTotal(reports).toString(),
                    txtColor: whiteColor,
                  ),

                  // CustomTableCell(txt: totalIncome.toString()),
                  const MyColoredTableCell(txt: ''),
                  const MyColoredTableCell(txt: ''),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

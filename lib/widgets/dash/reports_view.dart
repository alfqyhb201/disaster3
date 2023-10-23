import 'package:clay_containers/clay_containers.dart';
import 'package:disaster/pages/reports/annual_report_page.dart';
import 'package:disaster/pages/reports/daily_report.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:flutter/material.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        // width: MediaQuery.of(context).size.width - 170,
        // height: MediaQuery.of(context).size.height - 170,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0xAF000000),
              offset: Offset(0, 5),
              blurRadius: 5.0,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0xAF606060),
              offset: Offset(0, -5),
              blurRadius: 5.0,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0xFF4A5DF0),
              offset: Offset(-3, -3),
              blurRadius: 4.0,
              spreadRadius: 1,
            ),
          ],
          // gradient: const LinearGradient(
          //   begin: Alignment(0.68, -0.3),
          //   end: Alignment(-0.68, 2.73),
          //   colors: [
          //     // Color(0xFF43AF5C),
          //     Color(0xFF323232),
          //     Color(0xFF4A5DF0),
          //     // Color(0xFFa00D00),
          //     // Color(0xFFa00D00),
          //   ],
          //   // tileMode: TileMode.repeated,
          //   transform: GradientRotation(3.5),
          // ),
        ),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 50.0,
          // clipBehavior: Clip.antiAlias,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DailyReportPage(),
                    ));
              },
              child: ClayContainer(
                width: 100.0,
                height: 150.0,
                color: tealColor,
                depth: 50,
                borderRadius: 20.0,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      image: AssetImage(
                        'asset/daily_report.jpg',
                      ),
                      opacity: 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'الدخل اليومي',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnnualReportPage(),
                    ));
              },
              child: ClayContainer(
                width: 100.0,
                height: 150.0,
                color: tealColor,
                depth: 50,
                borderRadius: 20.0,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      image: AssetImage(
                        'asset/annual_report.jpg',
                      ),
                      opacity: 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'التقرير السنوي',
                      style: TextStyle(
                        color: yellowColor,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

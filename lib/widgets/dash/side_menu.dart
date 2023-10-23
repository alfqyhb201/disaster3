import 'package:clay_containers/clay_containers.dart';
import 'package:disaster/providers/users_provider.dart';
import 'package:disaster/services/database_services.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/reports_model.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    dailyIncomeDialog(ctx) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: blackColor,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(
                width: 2,
                color: blueColor,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            clipBehavior: Clip.antiAlias,
            content: SizedBox(
              width: 300,
              height: 200.0,
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClayContainer(
                        color: greenColor,
                        width: 50.0,
                        height: 50.0,
                        borderRadius: 40.0,
                        depth: 50,
                        spread: 2,
                        parentColor: Colors.black,
                        curveType: CurveType.convex,
                        child: Icon(
                          Icons.price_change,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 60.0,
                      ),
                      const Center(
                        child: Text(
                          'دخل اليوم',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: whiteColor,
                            offset: const Offset(-2, -2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: FutureBuilder(
                          future: DatabaseServices.getDailyReports(0),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Text('0.0'),
                              );
                            }
                            double totalIncome = 0.0;
                            List<Reports>? reports = snapshot.data;
                            var values =
                                reports!.map((e) => double.parse(e.price));
                            totalIncome = values.fold(0, (a, b) => a + b);
                            if (kDebugMode) {
                              print(totalIncome);
                            }
                            return RichText(
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: totalIncome.toString(),
                                  ),
                                  const TextSpan(
                                    text: ' ريال',
                                    // text: totalIncome.toString(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: 90.0,
          // height: MediaQuery.of(context).size.height - 100,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          clipBehavior: Clip.antiAlias,
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
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  dailyIncomeDialog(context);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  constraints: const BoxConstraints(
                    maxWidth: 40.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Image.asset(
                    'asset/logo.png',
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                indent: 15.0,
                endIndent: 15.0,
                thickness: 2.0,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.pageController.hasClients) {
                    widget.pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: blueColor,
                        offset: const Offset(-2, -1),
                        blurRadius: 2.0,
                        spreadRadius: 0,
                      ),
                      const BoxShadow(
                        color: Color(0xFF50F0A0),
                        offset: Offset(2, 1),
                        blurRadius: 2.0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.home_sharp,
                    color: greenColor,
                  ),
                  // child: Image.asset(
                  //   'asset/home4.png',
                  //   width: 70.0,
                  //   // color: Colors.purpleAccent,
                  // ),
                ),
              ),
              // const Spacer(),
              GestureDetector(
                onTap: () {
                  if (widget.pageController.hasClients) {
                    widget.pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'asset/reports.png',
                    width: 70.0,
                    // color: Colors.purpleAccent,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'asset/home3.png',
                  width: 70.0,
                  // color: Colors.purpleAccent,
                ),
              ),
              // const Spacer(),
              const Divider(
                color: Colors.white,
                indent: 15.0,
                endIndent: 15.0,
                thickness: 2.0,
              ),

              Provider.of<UsersProvider>(context, listen: false)
                          .currentUser!
                          .rule !=
                      'user'
                  ? GestureDetector(
                      onTap: () {
                        if (widget.pageController.hasClients) {
                          widget.pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: blueColor,
                              offset: const Offset(-2, -1),
                              blurRadius: 2.0,
                              spreadRadius: 0,
                            ),
                            const BoxShadow(
                              color: Color(0xFF50F0A0),
                              offset: Offset(2, 1),
                              blurRadius: 2.0,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.settings,
                          color: redColor,
                        ),
                        // child: Image.asset(
                        //   'asset/gear.png',
                        //   width: 70.0,
                        //   // color: Colors.purpleAccent,
                        // ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

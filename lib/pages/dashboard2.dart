import 'package:disaster/providers/counters/counter_provider.dart';
import 'package:disaster/providers/page_provider.dart';
import 'package:disaster/utilities/is_devices_running.dart';
import 'package:disaster/widgets/app_bar.dart';
import 'package:disaster/widgets/dash/counters_view.dart';
import 'package:disaster/widgets/dash/reports_view.dart';
import 'package:disaster/widgets/dash/setting_view.dart';
import 'package:disaster/widgets/dash/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard2 extends StatefulWidget {
  const Dashboard2({Key? key}) : super(key: key);

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<PageProvider>(context, listen: false).changePageNumber(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(const IsDevicesRunning(), true),
      backgroundColor: const Color(0xFF232323),
      body: Row(
        children: [
          SideMenu(pageController: pageController),
          Expanded(
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.vertical,
              children: const [
                CountersView(),
                ReportsView(),
                SettingView(),
              ],
            ),
          ),
          // Consumer<PageProvider>(
          //   builder: (context, value, _) {
          //     int pageNo = value.pageNumber;
          //     if (pageNo == 0) {
          //       return const CountersView();
          //     } else if (pageNo == 1) {
          //       return const ReportsView();
          //     }
          //     return const SettingView();
          //   },
          // ),
        ],
      ),
    );
  }
}

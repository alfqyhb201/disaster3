import 'package:disaster/models/devices_model.dart';
import 'package:disaster/services/database_services.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:disaster/widgets/dash/counters_cards/main_counter_card.dart';
import 'package:flutter/material.dart';

class CountersView extends StatefulWidget {
  const CountersView({Key? key}) : super(key: key);

  @override
  State<CountersView> createState() => _CountersViewState();
}

class _CountersViewState extends State<CountersView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        // width: MediaQuery.of(context).size.width - 170,
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
          ],
          // gradient: const LinearGradient(
          //   begin: Alignment(0.68, -0.3),
          //   end: Alignment(-0.68, 2.73),
          //   colors: [
          //     // Color(0xFF43AF5C),
          //     Color(0xFF4A5DF0),
          //     Color(0x5F4A5DF0),
          //     Color(0xFF323232),
          //     // Color(0xFF323232),
          //     Color(0xFF323232),
          //     // Color(0xFFa00D00),
          //     // Color(0xFFa00D00),
          //   ],
          //   // tileMode: TileMode.repeated,
          //   transform: GradientRotation(3.5),
          // ),
        ),
        child: FutureBuilder(
          future: DatabaseServices.getAllDevices(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('لا يوجد أجهزة'),
              );
            }
            List<Devices>? device = snapshot.data;
            return GridView.count(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,

              children: [
                ...List.generate(device!.length, (index) {
                  int idNumber = index + 1;
                  return MainCounterCard(
                      device: device[index], idNumber: idNumber);
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HexagonalClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(0, 0);
    path.lineTo(w / 2, 0);
    path.lineTo(w / 2, h / 2);
    path.lineTo(0, h / 2);
    // path.lineTo(0, h / 2);
    // path.lineTo(s, h / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

  // @override
  // bool shouldReclip(HexagonalClipper oldClipper) => true;
}

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final Color color;
  final String title;
  final String txtNumber;
  final IconData icon;
  const ReportCard(
      {Key? key,
      required this.color,
      required this.title,
      required this.txtNumber,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClayContainer(
        color: color,
        depth: 50,
        height: 150.0,
        spread: 2.0,
        borderRadius: 10.0,
        curveType: CurveType.convex,
        parentColor: Colors.black,
        surfaceColor: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8.0),
                    child: Center(
                      child: Text(
                        txtNumber,
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8.0),
                    child: Icon(
                      icon,
                      size: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

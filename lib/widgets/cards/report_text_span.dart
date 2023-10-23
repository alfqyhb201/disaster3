import 'package:disaster/utilities/colors.dart';
import 'package:flutter/material.dart';

class ReportTextSpan extends StatelessWidget {
  const ReportTextSpan({Key? key, required this.title, required this.price})
      : super(key: key);

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: blueColor,
        elevation: 10.0,
        // shadowColor: yellowColor,
        child: ListTile(
          // contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          title: Text(
            title,
            style: TextStyle(
              color: whiteColor.withOpacity(0.7),
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          subtitle: Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: RichText(
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              text: TextSpan(
                text: price,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
                children: const [
                  TextSpan(
                    text: ' ريال',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

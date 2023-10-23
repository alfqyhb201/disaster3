import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  final String txt;
  const CustomTableCell({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          txt,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}

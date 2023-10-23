import 'dart:math';

import 'package:flutter/material.dart';

class MyColoredTableCell extends StatelessWidget {
  final String txt;
  final Color? color;
  final Color? txtColor;
  final bool? txtDirection;
  final bool? isEmpty;
  const MyColoredTableCell(
      {Key? key,
      required this.txt,
      this.color,
      this.txtColor,
      this.txtDirection = true,
      this.isEmpty = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        color: color ?? Colors.transparent,
        child: !isEmpty!
            ? Text(
                txt,
                textDirection: txtDirection! ? TextDirection.rtl : null,
                style: TextStyle(
                  color: txtColor ?? Colors.black,
                ),
              )
            : Container(
                width: 50.0,
                height: 10.0,
                color: Colors.primaries
                    .elementAt(Random().nextInt(Colors.primaries.length)),
              ),
      ),
    );
  }
}

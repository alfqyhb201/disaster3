import 'package:clay_containers/clay_containers.dart';
import 'package:disaster/models/devices_model.dart';
import 'package:disaster/models/reports_model.dart';
import 'package:disaster/providers/users_provider.dart';
import 'package:disaster/services/database_services.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:disaster/utilities/date_format_functions.dart';
import 'package:disaster/widgets/circle_progress.dart';
import 'package:disaster/widgets/table_cells/table_cell.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:provider/provider.dart';

class CounterDialog extends StatefulWidget {
  final Devices device;
  final dynamic counterProvider;
  const CounterDialog(
      {Key? key, required this.device, required this.counterProvider})
      : super(key: key);

  @override
  State<CounterDialog> createState() => _CounterDialogState();
}

class _CounterDialogState extends State<CounterDialog> {
  final CountDownController controller = CountDownController();

  int minuteVal = 00;
  int hourVal = 00;

  bool isSpecified = false;

  int dropdownValue = 0;
  bool paymentBtn = false;

  int progressDuration = 14400;
  int progressInitVal = 0;

  late int cPrice;
  late final Devices _device;
  late dynamic _counterProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _device = widget.device;
    _counterProvider = widget.counterProvider;
    dropdownValue = _counterProvider.dropdownValue;
    // addAdd();
  }

  addAdd() {
    List.generate(10, (index) async {
      int a = index + 1;
      await DatabaseServices.addReport(
        Reports(
            device: 'deviceName',
            price: '1500.0',
            user: 'user',
            date: '2023/10/17 10:10 AM'),
      );
      if (kDebugMode) {
        print('aaaaaaa: $a');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseServices.controllerPrice().then((value) {
      cPrice = value;
    });
    if (_counterProvider.startSession) {
      paymentBtn = true;
    } else {
      paymentBtn = false;
    }
    finishCountProcessDialog(ctx) {
      // var durationSecond =
      //     Duration(seconds: _counterProvider.animation.value.toInt()).inSeconds;
      // double a = (cPrice / 3600) * durationSecond * dropdownValue;
      // int cpri = a.round();
      // var total = cpri + _counterProvider.price;

      return showDialog(
        context: context,
        builder: (context) {
          double totalPrice1 = _counterProvider.price.round().toDouble();
          totalPrice1 = (totalPrice1 / 5).round() * 5;
          if (kDebugMode) {
            // print(total);
            // print(cpri);
            print(totalPrice1);
          }
          return AlertDialog(
            backgroundColor: blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            actionsAlignment: MainAxisAlignment.center,
            clipBehavior: Clip.antiAlias,
            actions: [
              ClayContainer(
                width: 150.0,
                height: 50.0,
                color: Colors.green,
                parentColor: blueColor,
                depth: 40,
                borderRadius: 20.0,
                curveType: CurveType.convex,
                child: MaterialButton(
                  onPressed: () {
                    String deviceName = _device.name;
                    String totalPrice = totalPrice1.toString();

                    String user =
                        Provider.of<UsersProvider>(context, listen: false)
                            .currentUser!
                            .name;
                    String date =
                        DateTimeFunctions().formatDateTimeNow().toString();
                    DatabaseServices.addReport(Reports(
                            device: deviceName,
                            price: totalPrice,
                            user: user,
                            date: date))
                        .then((value) {
                      if (value != 0) {
                        _counterProvider.resetTimerValues();
                        _counterProvider.isZero = true;
                        _counterProvider.dropdownValue = 0;

                        Navigator.pop(context);
                      }
                    });
                  },
                  child: const Text(
                    'تأكيد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
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
                        color: Colors.pink,
                        width: 50.0,
                        height: 50.0,
                        borderRadius: 40.0,
                        depth: 50,
                        spread: 2,
                        parentColor: Colors.black,
                        surfaceColor: Colors.pink,
                        curveType: CurveType.convex,
                        child: const Icon(Icons.payment),
                      ),
                      const SizedBox(
                        width: 80.0,
                      ),
                      const Center(
                        child: Text(
                          'تسديد',
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
                    child: ClayContainer(
                      color: blueColor,
                      depth: 40,
                      spread: 3,
                      borderRadius: 10.0,
                      parentColor: Colors.black,
                      curveType: CurveType.convex,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: [
                          Table(
                            border: TableBorder.all(),
                            textDirection: TextDirection.rtl,
                            children: [
                              TableRow(
                                decoration: const BoxDecoration(
                                    // color: tealColor.withOpacity(0.9),
                                    ),
                                children: [
                                  const CustomTableCell(txt: 'السعر'),
                                  CustomTableCell(txt: totalPrice1.toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
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

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 414,
        height: 600,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: 140.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: const BorderRadiusDirectional.vertical(
                  bottom: Radius.elliptical(200.0, 100.0),
                ),
              ),
              child: Center(
                child: Text(_device.name),
              ),
            ),
            // CircularProgressIndicator(
            //   value: 1.0 / _counter. * 100,
            // ),
            ClayContainer(
              color: _counterProvider.startSession
                  ? redColor.withOpacity(0.8)
                  : tealColor,
              height: 120,
              width: 120,
              borderRadius: 75,
              depth: 50,
              spread: 10,
              parentColor: Colors.black,
              curveType: CurveType.convex,
              child: Center(
                child: CustomPaint(
                  foregroundPainter: CircleProgress(
                    _counterProvider.animation.value,
                    _counterProvider.animationEnd.toInt(),
                    _counterProvider,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _counterProvider.price.round().toDouble().toString(),
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        _counterProvider.animationValString,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClayContainer(
                  color: tealColor,
                  height: 50,
                  width: 150,
                  borderRadius: 25,
                  depth: 50,
                  spread: 10,
                  parentColor: Colors.black,
                  curveType: CurveType.convex,
                  surfaceColor:
                      !_counterProvider.isSpecified ? purpleColor : tealColor,
                  child: RadioListTile(
                    value: false,
                    groupValue: _counterProvider.isSpecified,
                    onChanged: (value) {
                      _counterProvider.isSpecified = false;
                      _counterProvider.animationEndSet = 14400.0;
                      _counterProvider.setHourAndMinute(hour: 0, minute: 0);
                    },
                    title: const Text('غير محدد'),
                    isThreeLine: false,
                    activeColor: Colors.amberAccent,
                  ),
                ),
                ClayContainer(
                  height: 50,
                  width: 150,
                  color: tealColor,
                  borderRadius: 25,
                  depth: 50,
                  spread: 10,
                  parentColor: Colors.black,
                  curveType: CurveType.convex,
                  surfaceColor:
                      _counterProvider.isSpecified ? purpleColor : tealColor,
                  child: RadioListTile(
                    value: true,
                    groupValue: _counterProvider.isSpecified,
                    onChanged: (value) {
                      _counterProvider.isSpecified = true;
                    },
                    title: const Text('محدد'),
                    isThreeLine: false,
                    activeColor: Colors.amberAccent,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ClayContainer(
                height: 80.0,
                borderRadius: 25,
                depth: 50,
                spread: 10,
                parentColor: Colors.black,
                curveType: CurveType.convex,
                surfaceColor: purpleColor,
                child: Visibility(
                  visible: _counterProvider.isSpecified,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: _counterProvider.hourVal,
                                minute: _counterProvider.minuteVal),
                            cancelText: 'الغاء',
                            confirmText: 'تأكيد',
                            builder: (context, child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child ?? Container(),
                              );
                            },
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                _counterProvider.setHourAndMinute(
                                    hour: value.hour, minute: value.minute);
                                hourVal = value.hour;
                                minuteVal = value.minute;
                                progressDuration =
                                    Duration(hours: hourVal).inSeconds +
                                        Duration(minutes: minuteVal).inSeconds;
                                _counterProvider.animationEndSet =
                                    progressDuration.toDouble();
                                _counterProvider.animationBeginSet =
                                    _counterProvider.animation.value;
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                              '${_counterProvider.hourVal}.${_counterProvider.minuteVal}'),
                        ),
                      ),
                      const Text('وقت التحديد'),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ClayContainer(
                height: 80.0,
                borderRadius: 25,
                depth: 50,
                spread: 10,
                parentColor: Colors.black,
                curveType: CurveType.convex,
                surfaceColor: const Color(0xFF5F3255),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButton(
                        value: dropdownValue,
                        items: <int>[0, 1, 2]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        dropdownColor: tealColor,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                          _counterProvider.cPrice = cPrice;
                          _counterProvider.dropdownValue = dropdownValue;
                        },
                      ),
                    ),
                    const Text('يد اضافية'),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClayContainer(
                  height: 50.0,
                  width: 100,
                  color: blueColor,
                  borderRadius: 25,
                  depth: 50,
                  spread: 10,
                  curveType: CurveType.convex,
                  parentColor: Colors.black,
                  child: MaterialButton(
                    onPressed: !paymentBtn
                        ? null
                        : () {
                            double aa =
                                double.parse(_counterProvider.price.toString());
                            if (aa <= 10) {
                              _counterProvider.resetTimerValues();
                              _counterProvider.isZero = true;
                              _counterProvider.dropdownValue = 0;
                            } else {
                              finishCountProcessDialog(context);
                            }
                          },
                    hoverColor: Colors.transparent,
                    child: const Text('تسديد'),
                  ),
                ),
                ClayContainer(
                  height: 50.0,
                  width: 100,
                  color: _counterProvider.startSession
                      ? blueColor
                      : const Color(0xFF5F3255),
                  borderRadius: 25,
                  depth: 50,
                  spread: 10,
                  curveType: CurveType.convex,
                  parentColor: Colors.black,
                  child: MaterialButton(
                    onPressed: () {
                      if (_counterProvider.startSession) {
                        // Start Animation

                        _counterProvider.changeSessionStatus(false);
                        _counterProvider.startAnimation();
                      } else {
                        // Stop Animation

                        _counterProvider.changeSessionStatus(true);
                        _counterProvider.stopAnimation();

                        if (_counterProvider.animation.value == 0) {
                          _counterProvider.isZero = true;
                        } else {
                          _counterProvider.isZero = false;
                        }
                      }
                    },
                    hoverColor: Colors.transparent,
                    child: Text(_counterProvider.startSession
                        ? 'بدء الجلسة'
                        : 'انهاء الجلسة'),
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

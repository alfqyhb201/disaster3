import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/counters/counter_provider.dart';
import '../providers/counters/counter_provider2.dart';
import '../providers/counters/counter_provider3.dart';
import '../providers/counters/counter_provider4.dart';
import '../providers/counters/counter_provider5.dart';
import '../providers/counters/counter_provider6.dart';
import '../providers/counters/counter_provider7.dart';
import '../providers/counters/counter_provider8.dart';

class IsDevicesRunning extends StatefulWidget {
  const IsDevicesRunning({Key? key}) : super(key: key);

  @override
  State<IsDevicesRunning> createState() => _IsDevicesRunningState();
}

class _IsDevicesRunningState extends State<IsDevicesRunning> {
  bool isDevicesRunning() {
    if (Provider.of<CounterProvider>(context, listen: false).price != 0.0) {
      return true;
    }
    if (Provider.of<CounterProvider2>(context, listen: false).price != 0.0) {
      return true;
    }
    if (Provider.of<CounterProvider3>(context, listen: false).price != 0.0) {
      return true;
    }
    if (Provider.of<CounterProvider4>(context, listen: false).price != 0.0) {
      return true;
    }
    if (Provider.of<CounterProvider5>(context, listen: false).price != 0.0) {
      return true;
    }
    if (Provider.of<CounterProvider6>(context, listen: false).price != 0.0) {
      return true;
    }
    if (Provider.of<CounterProvider7>(context, listen: false).price != 0.0) {
      return true;
    }
    if (Provider.of<CounterProvider8>(context, listen: false).price != 0.0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (!isDevicesRunning()) {
          Navigator.pop(context);
        }
        print(isDevicesRunning());
      },
      child: const Icon(Icons.logout, textDirection: TextDirection.rtl),
    );
  }
}

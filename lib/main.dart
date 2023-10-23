import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:disaster/providers/counters/counter_provider.dart';
import 'package:disaster/providers/page_provider.dart';
import 'package:disaster/providers/price_provider.dart';
import 'package:disaster/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/splash_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'providers/counters/counter_provider2.dart';
import 'providers/counters/counter_provider3.dart';
import 'providers/counters/counter_provider4.dart';
import 'providers/counters/counter_provider5.dart';
import 'providers/counters/counter_provider6.dart';
import 'providers/counters/counter_provider7.dart';
import 'providers/counters/counter_provider8.dart';
import 'utilities/colors.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(1300, 750);

    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Disaster";
    appWindow.show();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PriceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider(vsync: this),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider2(vsync: this),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider3(vsync: this),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider4(vsync: this),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider5(vsync: this),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider6(vsync: this),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider7(vsync: this),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterProvider8(vsync: this),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.black45,
          colorScheme: const ColorScheme.dark(),
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(Colors.white),
            // splashRadius: 30.0,
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(blueColor),
            trackBorderColor: MaterialStateProperty.all(blueColor),
            interactive: true,
            radius: const Radius.circular(20.0),
          ),
        ),
        locale: const Locale('ar'),
        home: WindowBorder(
          color: blueColor,
          width: 1.0,
          child: const SplashScreen(),
        ),
        // home: const SplashScreen(),
      ),
    );
  }
}

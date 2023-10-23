import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterProvider5 with ChangeNotifier {
  bool _isZero = true;
  bool get isZero => _isZero;
  set isZero(bool val) {
    _isZero = val;
    notifyListeners();
  }

  double _animationBegin = 0.0;
  double get animationBegin => _animationBegin;
  set animationBeginSet(double begin) {
    _animationBegin = begin;
    notifyListeners();
  }

  double _animationEnd = 14400.0;
  double get animationEnd => _animationEnd;
  set animationEndSet(double end) {
    _animationEnd = end;
    notifyListeners();
  }

  int _minutsVal = 00;
  int _hourVal = 00;
  int get minuteVal => _minutsVal;
  int get hourVal => _hourVal;

  void setHourAndMinute({required int hour, required int minute}) {
    _minutsVal = minute;
    _hourVal = hour;
    notifyListeners();
  }

  bool _isSpecified = false;
  bool get isSpecified => _isSpecified;
  set isSpecified(bool check) {
    _isSpecified = check;
    notifyListeners();
  }

  final double _cnt = 0.0;
  double get cnt => _cnt;

  String _animationValString = '00:00:00';
  String get animationValString => _animationValString;

  int _devicePrice = 400;
  int get devicePrice => _devicePrice;
  set devicePrice(int val) {
    _devicePrice = val;
    notifyListeners();
  }

  double _price = 0.0;
  double get price => _price;

  bool _startSession = true;
  bool get startSession => _startSession;

  int _cPrice = 0;
  int get cPrice => _cPrice;
  set cPrice(int val) {
    _cPrice = val;
    notifyListeners();
  }

  int _dropdownValue = 0;
  int get dropdownValue => _dropdownValue;
  set dropdownValue(int val) {
    _dropdownValue = val;
    notifyListeners();
  }

  void changeSessionStatus(bool check) {
    _startSession = check;
    notifyListeners();
  }

  late AnimationController _animationController;
  late Animation<double> _animation;

  late Timer _timer;

  CounterProvider5({required TickerProvider vsync}) {
    _animationController = AnimationController(
        vsync: vsync, duration: Duration(seconds: _animationEnd.toInt()))
      ..addListener(() {
        // if (_animation.value >= _animationEnd) {
        //   _isZero = false;
        //   _startSession = true;
        //   stopAnimation();
        //
        //   SystemSound.play(SystemSoundType.alert);
        //   notifyListeners();
        // }
      });

    _animation = Tween<double>(begin: _animationBegin, end: _animationEnd)
        .animate(_animationController)
      ..addListener(() {
        // var durationSecond =
        //     Duration(seconds: _animation.value.toInt()).inSeconds;
        //
        // Duration duration = Duration(seconds: durationSecond);
        // DateTime time = DateTime(0, 0, 0).add(duration);
        // String newFormat =
        //     '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
        // _animationValString = newFormat;
        // var price = (_devicePrice / 60 / 60) * durationSecond;
        // _price = price.round().toDouble();
        // notifyListeners();
      });
  }

  AnimationController get animationController => _animationController;
  Animation<double> get animation => _animation;

  void startAnimation() {
    _animationController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var durationSecond =
          Duration(seconds: _animation.value.toInt()).inSeconds;

      Duration duration = Duration(seconds: durationSecond);
      DateTime time = DateTime(0, 0, 0).add(duration);
      String newFormat =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
      _animationValString = newFormat;
      double a = (_cPrice / 3600) * _dropdownValue;
      var price = _price + (_devicePrice / 60 / 60) + a;
      // var price = (_devicePrice / 60 / 60) * durationSecond;
      _price = price;
      notifyListeners();

      if (_animation.value >= _animationEnd) {
        _isZero = false;
        _startSession = true;
        stopAnimation();

        SystemSound.play(SystemSoundType.alert);
        notifyListeners();
      }
    });
  }

  void stopAnimation() {
    _animationController.stop();
    _timer.cancel();
  }

  void resetTimerValues() {
    _animationBegin = 0.0;
    _animationEnd = 14400.0;
    _minutsVal = 00;
    _hourVal = 00;
    _isSpecified = false;
    _animationValString = '00:00:00';
    _price = 0.0;
    _startSession = true;
    _animationController.reset();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}

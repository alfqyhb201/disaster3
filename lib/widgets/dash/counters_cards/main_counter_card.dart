import 'package:clay_containers/clay_containers.dart';
import 'package:disaster/models/devices_model.dart';
import 'package:disaster/providers/counters/counter_provider.dart';
import 'package:disaster/providers/price_provider.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/counters/counter_provider2.dart';
import '../../../providers/counters/counter_provider3.dart';
import '../../../providers/counters/counter_provider4.dart';
import '../../../providers/counters/counter_provider5.dart';
import '../../../providers/counters/counter_provider6.dart';
import '../../../providers/counters/counter_provider7.dart';
import '../../../providers/counters/counter_provider8.dart';
import '../../dialogs/counter_dialog.dart';

class MainCounterCard extends StatefulWidget {
  final Devices device;
  final int idNumber;
  const MainCounterCard(
      {Key? key, required this.device, required this.idNumber})
      : super(key: key);

  @override
  State<MainCounterCard> createState() => _MainCounterCardState();
}

class _MainCounterCardState extends State<MainCounterCard> {
  late Devices _device;
  dynamic counterProvider;

  providerInit(id) {
    if (id == 1) {
      counterProvider = Provider.of<CounterProvider>(context);
    } else if (id == 2) {
      counterProvider = Provider.of<CounterProvider2>(context);
    } else if (id == 3) {
      counterProvider = Provider.of<CounterProvider3>(context);
    } else if (id == 4) {
      counterProvider = Provider.of<CounterProvider4>(context);
    } else if (id == 5) {
      counterProvider = Provider.of<CounterProvider5>(context);
    } else if (id == 6) {
      counterProvider = Provider.of<CounterProvider6>(context);
    } else if (id == 7) {
      counterProvider = Provider.of<CounterProvider7>(context);
    } else {
      counterProvider = Provider.of<CounterProvider8>(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _device = widget.device;
  }

  @override
  Widget build(BuildContext context) {
    providerInit(widget.idNumber);
    final PriceProvider priceProvider =
        Provider.of<PriceProvider>(context, listen: false);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_device.isPs4 == 1) {
          counterProvider.devicePrice = priceProvider.prices4;
        } else {
          counterProvider.devicePrice = priceProvider.prices5;
        }
      },
    );
    String image =
        _device.isPs4 == 1 ? 'asset/ps4_device.png' : 'asset/ps5_device.png';
    String logo =
        _device.isPs4 == 1 ? 'asset/ps4_logo.png' : 'asset/ps5_logo.png';
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: whiteColor,
            offset: const Offset(-2, -1),
            blurRadius: 2.0,
            spreadRadius: 0,
          ),
          const BoxShadow(
            color: Color(0xFF505050),
            offset: Offset(2, 1),
            blurRadius: 2.0,
            spreadRadius: 2,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    // height: 200.0,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    logo,
                    fit: BoxFit.fitWidth,
                    // height: 200.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClayContainer(
                  // color: counterProvider.startSession
                  //     ? Colors.black
                  //     : const Color(0xFF0DF000),
                  color: Colors.black,
                  height: 150,
                  width: 130,
                  borderRadius: 20,
                  depth: 100,
                  spread: 5,
                  emboss: true,
                  parentColor: counterProvider.startSession
                      ? (counterProvider.isZero ? redColor : yellowColor)
                      : greenColor,

                  curveType: CurveType.convex,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _device.name,
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w700),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(counterProvider.animationValString),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: ClayContainer(
                    // height: 50.0,
                    // width: 100,
                    color: blueColor,
                    borderRadius: 25,
                    depth: 50,
                    spread: 10,
                    curveType: CurveType.convex,
                    parentColor: Colors.black,
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AnimatedBuilder(
                                animation: counterProvider,
                                builder: (context, child) {
                                  return CounterDialog(
                                    device: _device,
                                    counterProvider: counterProvider,
                                  );
                                });
                          },
                        );
                      },
                      minWidth: 120.0,
                      height: 50.0,
                      hoverColor: Colors.transparent,
                      child: const Icon(Icons.play_arrow),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

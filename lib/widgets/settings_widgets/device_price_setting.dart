import 'package:clay_containers/clay_containers.dart';
import 'package:disaster/models/controller_model.dart';
import 'package:disaster/models/prices_model.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../services/database_services.dart';

class DevicePriceSetting extends StatefulWidget {
  const DevicePriceSetting({Key? key}) : super(key: key);

  @override
  State<DevicePriceSetting> createState() => _DevicePriceSettingState();
}

class _DevicePriceSettingState extends State<DevicePriceSetting> {
  TextEditingController ps4Controller = TextEditingController();
  TextEditingController ps5Controller = TextEditingController();
  TextEditingController cPriceController = TextEditingController();

  var controllerPrice = DatabaseServices.controllerPrice();
  var price = DatabaseServices.getAllPrices();
  List<Prices>? pricesList = [];
  Prices? prices4;
  Prices? prices5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    price.then((value) {
      if (value != null) {
        prices4 = value.first;
        prices5 = value.last;
        ps4Controller.text = prices4!.price.toString();
        ps5Controller.text = prices5!.price.toString();
      }
    });
    controllerPrice.then((value) {
      cPriceController.text = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      decoration: BoxDecoration(
        // color: Colors.indigo,
        borderRadius: BorderRadius.circular(40.0),
        gradient: const LinearGradient(
          begin: Alignment(0.68, -0.3),
          end: Alignment(-0.68, 1.0),
          colors: [
            Color(0xFF0D1879),
            Color(0xFFB01D8F),
            // Color(0xFF433F6C),
          ],
          // tileMode: TileMode.repeated,
          transform: GradientRotation(3.5),
        ),
        boxShadow: [
          BoxShadow(
            color: greenColor,
            offset: const Offset(3, 3),
            blurRadius: 10.0,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'الأسعار',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            height: 3.0,
            color: Colors.white,
            indent: 30.0,
            endIndent: 30.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.rtl,
            children: [
              const Text('بلاستيشن 4'),
              SizedBox(
                width: 150,
                height: 40.0,
                child: TextField(
                  controller: ps4Controller,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          ClayContainer(
            color: blueColor,
            parentColor: Colors.black,
            depth: 50,
            spread: 3.0,
            borderRadius: 20.0,
            curveType: CurveType.convex,
            child: MaterialButton(
              onPressed: () async {
                await DatabaseServices.updatePrice(Prices(
                    id: prices4!.id,
                    device: 'ps4',
                    price: int.parse(ps4Controller.text)));
                // ignore: use_build_context_synchronously
                MotionToast.success(
                  description: const Text("تم التعديل بنجاح"),
                  layoutOrientation: ToastOrientation.rtl,
                  animationType: AnimationType.fromTop,
                  // width: 300,
                ).show(context);
              },
              // color: blueColor,
              child: const Text('تعديل'),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            height: 3.0,
            color: Colors.white,
            indent: 30.0,
            endIndent: 30.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.rtl,
            children: [
              const Text('بلاستيشن 5'),
              SizedBox(
                width: 150,
                height: 40.0,
                child: TextField(
                  controller: ps5Controller,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          ClayContainer(
            color: blueColor,
            parentColor: Colors.black,
            depth: 50,
            spread: 3.0,
            borderRadius: 20.0,
            curveType: CurveType.convex,
            child: MaterialButton(
              onPressed: () async {
                await DatabaseServices.updatePrice(Prices(
                    id: prices5!.id,
                    device: 'ps5',
                    price: int.parse(ps5Controller.text)));
                // ignore: use_build_context_synchronously
                MotionToast.success(
                  description: const Text("تم التعديل بنجاح"),
                  layoutOrientation: ToastOrientation.rtl,
                  animationType: AnimationType.fromTop,
                  // width: 300,
                ).show(context);
              },
              child: const Text('تعديل'),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            height: 3.0,
            color: Colors.white,
            indent: 30.0,
            endIndent: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.rtl,
            children: [
              const Text('سعر اضافة يد'),
              SizedBox(
                width: 150,
                height: 40.0,
                child: TextField(
                  controller: cPriceController,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          ClayContainer(
            color: blueColor,
            parentColor: Colors.black,
            depth: 50,
            spread: 3.0,
            borderRadius: 20.0,
            curveType: CurveType.convex,
            child: MaterialButton(
              onPressed: () async {
                await DatabaseServices.updateControllerPrice(
                    Controller(id: 1, price: int.parse(cPriceController.text)));
                // ignore: use_build_context_synchronously
                MotionToast.success(
                  description: const Text("تم التعديل بنجاح"),
                  layoutOrientation: ToastOrientation.rtl,
                  animationType: AnimationType.fromTop,
                  // width: 300,
                ).show(context);
              },
              child: const Text('تعديل'),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            height: 3.0,
            color: Colors.white,
            indent: 30.0,
            endIndent: 30.0,
          ),
        ],
      ),
    );
  }
}

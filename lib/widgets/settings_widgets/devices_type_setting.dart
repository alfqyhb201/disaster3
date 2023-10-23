import 'package:disaster/services/database_services.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:disaster/widgets/settings_widgets/device_switch_type.dart';
import 'package:flutter/material.dart';

class DevicesTypeSetting extends StatefulWidget {
  const DevicesTypeSetting({Key? key}) : super(key: key);

  @override
  State<DevicesTypeSetting> createState() => _DevicesTypeSettingState();
}

class _DevicesTypeSettingState extends State<DevicesTypeSetting> {
  @override
  Widget build(BuildContext context) {
    // DatabaseServices.getAllDevices().then((value) => print(value!.first.name));
    return Container(
      width: 400,
      height: 600,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      decoration: BoxDecoration(
        // color: Colors.indigo,
        borderRadius: BorderRadius.circular(40.0),
        gradient: const LinearGradient(
          begin: Alignment(0.68, -0.3),
          end: Alignment(-0.68, 1.0),
          colors: [
            Color(0xFFB01D8F),
            Color(0xFF0D1879),
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'الاجهزة',
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
            FutureBuilder(
              future: DatabaseServices.getAllDevices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var device = snapshot.data;
                  return Column(
                    children: [
                      ...List.generate(device!.length, (index) {
                        return DeviceSwitchType(device: device[index]);
                      }),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

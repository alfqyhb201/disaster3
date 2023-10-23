import 'package:disaster/models/devices_model.dart';
import 'package:disaster/services/database_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceSwitchType extends StatefulWidget {
  final Devices device;
  const DeviceSwitchType({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceSwitchType> createState() => _DeviceSwitchTypeState();
}

class _DeviceSwitchTypeState extends State<DeviceSwitchType> {
  String name = '';
  int? id;
  late bool isPs4;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.device.name;
    id = widget.device.id;
    isPs4 = widget.device.isPs4 == 1;
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.device.isPs4.toString());
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textDirection: TextDirection.rtl,
          children: [
            Text(name),
            Image.asset(
              'asset/ps4_logo.png',
              width: 100.0,
            ),
            Switch(
              value: isPs4,
              onChanged: (value) async {
                int is4 = !isPs4 ? 1 : 0;
                int check = await DatabaseServices.updateDevice(
                    Devices(id: id, name: name, isPs4: is4));
                if (check != 0) {
                  setState(() {
                    isPs4 = !isPs4;
                  });
                }
              },
              activeColor: Colors.orange,
              inactiveTrackColor: Colors.blue,
              inactiveThumbColor: Colors.white,
            ),
            Image.asset(
              'asset/ps5_logo.png',
              width: 70.0,
            ),
          ],
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
      ],
    );
  }
}

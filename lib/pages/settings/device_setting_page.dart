import 'package:disaster/utilities/colors.dart';
import 'package:disaster/widgets/settings_widgets/device_price_setting.dart';
import 'package:disaster/widgets/settings_widgets/devices_type_setting.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class DeviceSettingPage extends StatefulWidget {
  const DeviceSettingPage({Key? key}) : super(key: key);

  @override
  State<DeviceSettingPage> createState() => _DeviceSettingPageState();
}

class _DeviceSettingPageState extends State<DeviceSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: customAppBar(true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    DevicePriceSetting(),
                    DevicesTypeSetting(),
                    // DevicePriceSetting(),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

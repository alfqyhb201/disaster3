import 'package:clay_containers/clay_containers.dart';
import 'package:disaster/pages/settings/device_setting_page.dart';
import 'package:disaster/pages/settings/user_setting_page.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        // width: MediaQuery.of(context).size.width - 170,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.indigo,
          borderRadius: BorderRadius.circular(40.0),
          gradient: LinearGradient(
            begin: const Alignment(0.68, -0.3),
            end: const Alignment(-0.68, 2.73),
            colors: [
              blackColor,
              redColor.withOpacity(0.5),
            ],
            transform: const GradientRotation(3.5),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFAF5C66),
              offset: Offset(3, 3),
              blurRadius: 20.0,
              spreadRadius: 1,
            ),
          ],
        ),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 50.0,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserSettingPage(),
                    ));
              },
              child: ClayContainer(
                width: 100.0,
                height: 300.0,
                color: tealColor,
                depth: 50,
                borderRadius: 20.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  height: 300,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      image: AssetImage(
                        'asset/manage_users.jpg',
                      ),
                      opacity: 0.5,
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'المستخدمين',
                        maxLines: 1,
                        textDirection: TextDirection.rtl,
                        minFontSize: 5.0,
                        style: TextStyle(
                          color: whiteColor,
                          backgroundColor: Colors.black45,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AutoSizeText(
                        'تعديل، حذف واضافة المستخدمين',
                        maxLines: 1,
                        textDirection: TextDirection.rtl,
                        minFontSize: 5.0,
                        style: TextStyle(
                          color: whiteColor,
                          backgroundColor: Colors.black45,
                          fontSize: 20.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'asset/users_setting.png',
                  // width: 500.0,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: 200.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 180.0, left: 160.0),
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserSettingPage(),
                            ));
                      },
                      child: const Text('أدارة'),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'asset/device_setting.png',
                  // width: 500.0,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: 200.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 180.0, left: 160.0),
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeviceSettingPage(),
                            ));
                      },
                      child: const Text('أدارة'),
                    ),
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

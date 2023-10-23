import 'package:disaster/models/users_model.dart';
import 'package:disaster/pages/login_screen.dart';
import 'package:disaster/services/database_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var users = DatabaseServices.getAllUsers();
    users.then((value) {
      // print(value!.first.name);
      if (value == null) {
        DatabaseServices.addUser(
            const Users(name: 'admin', password: '123', rule: 'admin'));
      }
    });

    Future.delayed(const Duration(seconds: 10), () async {
      debugPrint('End Splash Screen');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
    // List<String> availablePort = SerialPort.availablePorts;
    // debugPrint("available Ports: $availablePort");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customAppBar,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            'asset/ps_controller.gif',
            // 'asset/play.gif',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

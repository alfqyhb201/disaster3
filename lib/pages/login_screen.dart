import 'package:disaster/pages/dashboard2.dart';
import 'package:disaster/providers/users_provider.dart';
import 'package:disaster/services/database_services.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:disaster/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool isAdmin = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset.fromDirection(10.0),
      end: const Offset(0.0, 25.0),
    ).animate(_controller);
    // _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // width: 1440,
              // height: 1024,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.68, -1.3),
                  end: const Alignment(-0.58, 0.93),
                  colors: [
                    blackColor,
                    blackColor,
                    blackColor,
                    const Color(0x5D01199F),
                    // const Color(0xFD01192F),
                    // const Color(0xFD01192F),
                    // const Color(0xFF4A5DF0),
                    // Color(0xFD51192F),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Positioned(
                  //   left: 0,
                  //   top: 0,
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     // height: MediaQuery.of(context).size.height,
                  //     child: Image.asset('asset/bb.jpg', fit: BoxFit.cover),
                  //   ),
                  // ),
                  Positioned(
                    left: 512,
                    top: 104,
                    child: Container(
                      width: 738,
                      height: 510,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 30.0),
                      decoration: ShapeDecoration(
                        color: blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        shadows: [
                          BoxShadow(
                            color: blueColor,
                            offset: const Offset(10, 10),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: whiteColor,
                            offset: const Offset(-1, -1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'سجل الدخول',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w900,
                              height: 0,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            width: 344,
                            padding: const EdgeInsets.only(
                                top: 4, right: 8, bottom: 4),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: blueColor,
                                  offset: const Offset(-1, -1),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: blackColor,
                                  offset: const Offset(1, 1),
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: RadioListTile(
                              value: true,
                              groupValue: isAdmin,
                              onChanged: (value) {
                                setState(() {
                                  isAdmin = value!;
                                });
                              },
                              title: const Text(
                                'مدير',
                                style: TextStyle(color: Colors.white),
                                textDirection: TextDirection.rtl,
                              ),
                              activeColor: Colors.orange,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 344,
                            padding: const EdgeInsets.only(
                                top: 4, right: 8, bottom: 4),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: blueColor,
                                  offset: const Offset(-1, -1),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: blackColor,
                                  offset: const Offset(1, 1),
                                  blurRadius: 20,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: RadioListTile(
                              value: false,
                              groupValue: isAdmin,
                              onChanged: (value) {
                                setState(() {
                                  isAdmin = value!;
                                });
                              },
                              title: const Text(
                                'عامل',
                                style: TextStyle(color: Colors.white),
                                textDirection: TextDirection.rtl,
                              ),
                              activeColor: Colors.orange,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: 344,
                                  height: 50.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  // height: 73,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  child: RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    child: TextFormField(
                                      controller: nameController,
                                      textDirection: TextDirection.rtl,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'الاسم',
                                        hintTextDirection: TextDirection.rtl,
                                        hintStyle: TextStyle(
                                          color: blueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'أدخل اسم المستخدم';
                                        }
                                        return null;
                                      },
                                    ),
                                    onKey: (value) {
                                      debugPrint(
                                          value.data.logicalKey.keyLabel);
                                      if (value.data.logicalKey.keyLabel ==
                                          "Backspace") {
                                        if (passwordController
                                            .text.isNotEmpty) {
                                          passwordController.text.substring(
                                              0,
                                              passwordController.text.length -
                                                  1);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  width: 344,
                                  height: 50.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  // height: 73,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  child: RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      textDirection: TextDirection.rtl,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'كلمة السر',
                                        hintTextDirection: TextDirection.rtl,
                                        hintStyle: TextStyle(
                                          color: blueColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'أدخل كلمة المرور';
                                        }
                                        return null;
                                      },
                                    ),
                                    onKey: (value) {
                                      debugPrint(
                                          value.data.logicalKey.keyLabel);
                                      if (value.data.logicalKey.keyLabel ==
                                          "Backspace") {
                                        if (passwordController
                                            .text.isNotEmpty) {
                                          passwordController.text.substring(
                                              0,
                                              passwordController.text.length -
                                                  1);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            width: 344,
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1E606060),
                                  blurRadius: 4,
                                  offset: Offset(5, 5),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x4C707070),
                                  blurRadius: 4,
                                  offset: Offset(-5, -5),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  // print('sadadadafsdfsd');
                                  return;
                                }
                                DatabaseServices.getUsers(
                                        isAdmin,
                                        nameController.text,
                                        passwordController.text)
                                    .then((value) {
                                  debugPrint(value?.first.name.toString());
                                  if (value == null) {
                                    return MotionToast.error(
                                      title: const Text("فشل"),
                                      description: const Text(
                                          "تأكد من كتابة البيانات بشكل صحيح"),
                                      layoutOrientation: ToastOrientation.rtl,
                                      animationType: AnimationType.fromTop,

                                      // width: 300,
                                    ).show(context);
                                  } else {
                                    Provider.of<UsersProvider>(context,
                                            listen: false)
                                        .updateCurrentUser(value.first);
                                    nameController.clear();
                                    passwordController.clear();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Dashboard2(),
                                        ));
                                  }
                                });
                              },
                              child: const Text('دخول'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 200,
                    child: AnimatedBuilder(
                      animation: _controller,
                      child: Image.asset(
                        'asset/game_controller2.png',
                        // 'asset/game_controller.png',
                        width: 700,
                      ),
                      builder: (context, child) {
                        return Transform.translate(
                          offset: _animation.value,
                          child: child,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

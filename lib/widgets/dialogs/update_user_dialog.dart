import 'package:disaster/models/users_model.dart';
import 'package:disaster/providers/users_provider.dart';
import 'package:disaster/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUserDialog {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showUpdateUser(context, user) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    nameController.text = user.name;
    passwordController.text = user.password;

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white70,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'تعديل مستخدم',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'كلمة المرور',
                                style: TextStyle(color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: 300.0,
                                child: CupertinoTextFormFieldRow(
                                  controller: passwordController,
                                  textDirection: TextDirection.rtl,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'الرجاء ادخال كلمة المرور';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'الاسم',
                                style: TextStyle(color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: 300.0,
                                child: RawKeyboardListener(
                                  focusNode: FocusNode(),
                                  child: CupertinoTextFormFieldRow(
                                    controller: nameController,
                                    textDirection: TextDirection.rtl,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'الرجاء ادخال الاسم';
                                      }
                                      return null;
                                    },
                                  ),
                                  onKey: (value) {
                                    debugPrint(value.data.logicalKey.keyLabel);
                                    if (value.data.logicalKey.keyLabel ==
                                        "Backspace") {
                                      if (nameController.text.isNotEmpty) {
                                        nameController.text.substring(
                                            0, nameController.text.length - 1);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFBEBEBE),
                          offset: Offset(10, 10),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-10, -10),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () async {
                        final FormState? form = formKey.currentState;
                        if (form!.validate()) {
                          await DatabaseServices.updateUser(Users(
                              id: user.id,
                              name: nameController.text,
                              password: passwordController.text,
                              rule: user.rule));
                          nameController.clear();
                          passwordController.clear();
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Provider.of<UsersProvider>(context, listen: false)
                              .getUsers();
                        } else {
                          if (kDebugMode) {
                            print('Form is invalid');
                          }
                        }
                      },
                      child: const Text(
                        'تعديل',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

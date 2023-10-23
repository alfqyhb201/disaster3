import 'package:disaster/providers/users_provider.dart';
import 'package:disaster/services/database_services.dart';
import 'package:disaster/utilities/colors.dart';
import 'package:disaster/widgets/app_bar.dart';
import 'package:disaster/widgets/dialogs/add_user_dialog.dart';
import 'package:disaster/widgets/dialogs/update_user_dialog.dart';
import 'package:disaster/widgets/table_cells/table_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  getUsrs() async {
    await Provider.of<UsersProvider>(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    getUsrs();
    // var users = Provider.of<UsersProvider>(context,listen: f);

    deleteDialog(ctx, users) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              CupertinoButton(
                color: Colors.indigo,
                // pressedOpacity: 0.5,
                onPressed: () async {
                  await DatabaseServices.deleteUser(users);
                  Navigator.pop(ctx);
                  MotionToast.success(
                    // title: const Text("فشل"),
                    description: const Text("تم الحذف بنجاح"),
                    layoutOrientation: ToastOrientation.rtl,
                    animationType: AnimationType.fromTop,

                    // width: 300,
                  ).show(ctx);
                },
                child: const Text(
                  'تأكيد',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            content: SizedBox(
              width: 300,
              height: 100.0,
              child: Column(
                children: [
                  Row(
                    // textDirection: TextDirection.rtl,
                    children: [
                      Expanded(
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: const Icon(Icons.delete),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: const Text(
                          'حذف مستخدم',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: blackColor,
      appBar: customAppBar(true),
      floatingActionButton: OutlinedButton(
        onPressed: () {
          AddUserDialog().showAddUser(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))),
        ),
        child: const Icon(Icons.add, size: 40.0),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            gradient: const LinearGradient(
              begin: Alignment(0.68, -0.3),
              end: Alignment(-0.68, 2.73),
              colors: [
                Color(0xFF420C46),
                Color(0xFF433F6C),
                Color(0xFF83AFAC),
              ],
              // tileMode: TileMode.repeated,
              transform: GradientRotation(3.5),
            ),
            boxShadow: [
              BoxShadow(
                color: blueColor,
                // color: Color(0xFFAF5C66),
                offset: const Offset(3, 3),
                blurRadius: 20.0,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Consumer<UsersProvider>(
            builder: (context, value, _) {
              var users = value.users;
              return Table(
                border: TableBorder.all(color: Colors.white),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                textDirection: TextDirection.rtl,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: blueColor,
                      border: Border.all(color: Colors.white),
                    ),
                    children: const [
                      CustomTableCell(txt: 'الرقم'),
                      CustomTableCell(txt: 'الاسم'),
                      CustomTableCell(txt: 'كلمة السر'),
                      CustomTableCell(txt: 'النوع'),
                      CustomTableCell(txt: 'الحدث'),
                    ],
                  ),
                  ...List.generate(users!.length, (index) {
                    return TableRow(
                      decoration: BoxDecoration(
                        color: tealColor,
                        border: Border.all(color: Colors.white),
                      ),
                      children: [
                        CustomTableCell(txt: users[index].id.toString()),
                        CustomTableCell(txt: users[index].name),
                        CustomTableCell(txt: users[index].password),
                        CustomTableCell(txt: users[index].rule),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      deleteDialog(context, users[index]);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      UpdateUserDialog().showUpdateUser(
                                          context, users[index]);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green)),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

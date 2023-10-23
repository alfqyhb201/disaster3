import 'package:disaster/models/users_model.dart';
import 'package:disaster/pages/dashboard2.dart';
import 'package:disaster/services/database_services.dart';
import 'package:disaster/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isHome = true;
  bool isHome2 = false;
  @override
  Widget build(BuildContext context) {
    var users = DatabaseServices.getAllUsers();
    return Scaffold(
      appBar: customAppBar(true),
      body: Row(
        children: [
          SideMenu(
            backgroundColor: Colors.deepPurple,
            builder: (data) => SideMenuData(
              header: const Text('Menu'),
              items: [
                SideMenuItemDataTile(
                  isSelected: isHome,
                  onTap: () {
                    setState(() {
                      isHome = true;
                      isHome2 = false;
                    });
                  },
                  title: 'Item 1',
                  icon: const Icon(Icons.home),
                  hoverColor: Colors.orange,
                  highlightSelectedColor: Colors.blue,
                ),
                SideMenuItemDataTile(
                  isSelected: isHome2,
                  onTap: () {
                    setState(() {
                      isHome2 = true;
                      isHome = false;
                    });
                    DatabaseServices.addUser(const Users(
                        name: 'Ali Mohammed',
                        password: '123456',
                        rule: 'admin'));
                  },
                  title: 'Item 1',
                  icon: const Icon(Icons.home),
                  hoverColor: Colors.orange,
                  highlightSelectedColor: Colors.blue,
                ),
                SideMenuItemDataTile(
                  isSelected: isHome2,
                  onTap: () {
                    setState(() {
                      isHome2 = true;
                      isHome = false;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard2(),
                        ));
                  },
                  title: 'Item 1',
                  icon: const Icon(Icons.home),
                  hoverColor: Colors.orange,
                  highlightSelectedColor: Colors.blue,
                ),
              ],
              footer: Text(DateTime.now().toString()),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                color: Colors.amber.shade50,
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: users,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    var ss = snapshot.data;
                    return Table(
                      border: TableBorder.all(color: Colors.black),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      textDirection: TextDirection.rtl,
                      children: [
                        ...List.generate(ss!.length, (index) {
                          return TableRow(
                            decoration: BoxDecoration(
                              // color: const Color(0xFF500050),
                              border: Border.all(color: Colors.white),
                            ),
                            children: [
                              Text(
                                ss[index].id.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                ss[index].name,
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                ss[index].password,
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                ss[index].rule,
                                style: const TextStyle(color: Colors.black),
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
          ),
        ],
      ),
    );
  }
}

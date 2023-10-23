import 'package:disaster/models/controller_model.dart';
import 'package:disaster/models/devices_model.dart';
import 'package:disaster/models/prices_model.dart';
import 'package:disaster/models/reports_model.dart';
import 'package:disaster/models/users_model.dart';
import 'package:disaster/utilities/date_format_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static const int _version = 1;
  static const String _dbName = "Users.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE Users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, password TEXT NOT NULL, rule TEXT NOT NULL);");
        await db.execute(
            "CREATE TABLE Prices(id INTEGER PRIMARY KEY AUTOINCREMENT, device TEXT NOT NULL, price INTEGER NOT NULL);");
        await db.execute(
            "CREATE TABLE Devices(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, isPs4 INTEGER NOT NULL);");
        await db.execute(
            "CREATE TABLE Controller(id INTEGER PRIMARY KEY AUTOINCREMENT, price INTEGER NOT NULL);");
        await db.execute(
            "CREATE TABLE Reports(id INTEGER PRIMARY KEY AUTOINCREMENT, device TEXT NOT NULL, price TEXT NOT NULL, user TEXT NOT NULL, date TEXT NOT NULL);");

        var price = {
          'device': 'ps4',
          'price': 400,
        };
        var price2 = {
          'device': 'ps5',
          'price': 600,
        };
        var controllerPrice = {
          'price': 100,
        };

        await db.insert('Prices', price);
        await db.insert('Prices', price2);
        await db.insert('Controller', controllerPrice);

        await addDevice(db, const Devices(name: 'جهاز 1', isPs4: 1));
        await addDevice(db, const Devices(name: 'جهاز 2', isPs4: 1));
        await addDevice(db, const Devices(name: 'جهاز 3', isPs4: 1));
        await addDevice(db, const Devices(name: 'جهاز 4', isPs4: 1));
        await addDevice(db, const Devices(name: 'جهاز 5', isPs4: 1));
        await addDevice(db, const Devices(name: 'جهاز 6', isPs4: 1));
        await addDevice(db, const Devices(name: 'جهاز 7', isPs4: 1));
        await addDevice(db, const Devices(name: 'جهاز 8', isPs4: 1));
      },
      version: _version,
    );
  }

  static Future<int> addUser(Users users) async {
    final db = await _getDB();
    return await db.insert('Users', users.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(Users users) async {
    final db = await _getDB();
    return await db.update(
      'Users',
      users.toJson(),
      where: 'id = ?',
      whereArgs: [users.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteUser(Users users) async {
    final db = await _getDB();
    return await db.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [users.id],
    );
  }

  static Future<List<Users>?> getAllUsers() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Users');

    if (maps.isEmpty) {
      return null;
    }
    List<Users> asd = [];
    for (var lis in maps) {
      asd.add(Users.fromJson(lis));
    }
    return asd;
  }

  static Future<List<Users>?> getUsers(
      bool isAdmin, String name, String pass) async {
    String rules = isAdmin ? 'admin' : 'user';
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'Users',
      where: "rule = ? AND name = ? AND password = ?",
      whereArgs: [rules, name, pass],
    );

    if (maps.isEmpty) {
      return null;
    }
    List<Users> asd = [];
    for (var lis in maps) {
      asd.add(Users.fromJson(lis));
    }
    return asd;
  }

  //-----------------------------------------------------------
  //-----------------------------------------------------------

  static Future<int> controllerPrice() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Controller');

    if (maps.isEmpty) {
      return 0;
    }
    List<Controller> asd = [];
    for (var lis in maps) {
      asd.add(Controller.fromJson(lis));
    }
    return asd.first.price;
  }

  static Future<int> updateControllerPrice(Controller controller) async {
    final db = await _getDB();
    return await db.update(
      'Controller',
      controller.toJson(),
      where: 'id = ?',
      whereArgs: [controller.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Prices>?> getAllPrices() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Prices');

    if (maps.isEmpty) {
      return null;
    }
    List<Prices> asd = [];
    for (var lis in maps) {
      asd.add(Prices.fromJson(lis));
    }
    return asd;
  }

  static Future<int> updatePrice(Prices prices) async {
    final db = await _getDB();
    return await db.update(
      'Prices',
      prices.toJson(),
      where: 'id = ?',
      whereArgs: [prices.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //-----------------------------------------------------------
  //-----------------------------------------------------------

  static addDevice(db, Devices devices) async {
    return await db.insert('Devices', devices.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Devices>?> getAllDevices() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Devices');

    if (maps.isEmpty) {
      return null;
    }
    List<Devices> asd = [];
    for (var lis in maps) {
      asd.add(Devices.fromJson(lis));
    }
    return asd;
  }

  static Future<int> updateDevice(Devices devices) async {
    final db = await _getDB();
    return await db.update(
      'Devices',
      devices.toJson(),
      where: 'id = ?',
      whereArgs: [devices.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //  ------------------------------------------------
  //  ------------------------------------------------
  static Future<int> addReport(Reports reports) async {
    final db = await _getDB();
    return await db.insert('Reports', reports.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Reports>?> getReports() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Reports');

    if (maps.isEmpty) {
      return null;
    }
    List<Reports> asd = [];
    for (var lis in maps) {
      asd.add(Reports.fromJson(lis));
    }
    return asd;
  }

  static Future<List<Reports>?> getAllReports() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Reports');

    if (maps.isEmpty) {
      return null;
    }
    List<Reports> asd = [];
    for (var lis in maps) {
      asd.add(Reports.fromJson(lis));
    }
    return asd;
  }

  static Future<List<Reports>?> getGroupedReports() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'Reports',
      groupBy: 'date',
    );

    if (maps.isEmpty) {
      return null;
    }
    List<Reports> asd = [];
    for (var lis in maps) {
      asd.add(Reports.fromJson(lis));
    }
    return asd;
  }

  static Future<List<Reports>?> getDailyReports(int day) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'Reports',
    );

    if (maps.isEmpty) {
      return null;
    }
    List<Reports> asd = [];
    for (var lis in maps) {
      if (kDebugMode) {
        // print(lis['date']);
        // print('45454565656565');
      }
      String dateString = lis['date'];
      // String dateString = '2023/10/2';
      int difference = DateTimeFunctions().dateDifference(dateString);
      if (difference == day) {
        asd.add(Reports.fromJson(lis));
      }
    }

    return asd.isEmpty ? null : asd;
  }
}

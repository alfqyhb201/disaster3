import 'package:disaster/services/database_services.dart';
import 'package:flutter/material.dart';

import '../models/users_model.dart';

class UsersProvider with ChangeNotifier {
  Users? _currentUser;
  Users? get currentUser => _currentUser;

  List<Users>? _users = [];
  List<Users>? get users => _users;

  getUsers() async {
    List<Users>? usrs = await DatabaseServices.getAllUsers();
    _users = usrs;
    notifyListeners();
  }

  updateCurrentUser(Users crtUser) {
    _currentUser = crtUser;
    notifyListeners();
  }
}

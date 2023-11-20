import 'package:rmgmapp/data.dart';
import 'package:rmgmapp/database_helper.dart';
import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<Data> dataList = [];
  DatabaseHelper dbHelper = DatabaseHelper();
  DataProvider() {
    _loadDataFromDatabase();
  }
  Future<void> _loadDataFromDatabase() async {
    dataList = await dbHelper.getData();
    notifyListeners();
  }

  Future<void> add(Data data) async {
    await dbHelper.insertData(data);
    _loadDataFromDatabase();
  }

  Future<void> delete(int id) async {
    await dbHelper.deleteData(id);
    _loadDataFromDatabase();
  }

  Future<void> edit(Data data) async {
    await dbHelper.updateData(data);
    _loadDataFromDatabase();
  }
}
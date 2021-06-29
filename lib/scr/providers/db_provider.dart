import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  ///  construtor privado
  DBProvider._();

  ///  construtor privado

  Future<Database> get database async {
    // la base de datos ya fue abierta
    if (_database != null) return _database;

    // abrir base de datos por primera vez

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'EmrgiContact.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
    );
  }
}

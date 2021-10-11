import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbTiposAplicaciones {
  static Database _database;

  static final DbTiposAplicaciones db = DbTiposAplicaciones._();
  DbTiposAplicaciones._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory docmentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(docmentsDirectory.path, 'Vitalfon.db');
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE TiposApi(
        id INTEGER PRIMARY KEY,
        nombre TEXT
        
      )
      ''');
    });
  }
}

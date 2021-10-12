import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piproy/scr/models/api_tipos.dart';
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
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE TiposApi(
        id INTEGER PRIMARY KEY,
        nombreApi TEXT,
        tipo TEXT
        
      )
      ''');
    });
  }

  Future<int> nuevoTipo(ApiTipos nuevo) async {
    final db = await database;
    final resp = await db.insert('TiposApi', nuevo.toJson());
    return resp;
  }
}

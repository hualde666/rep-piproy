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
    print(resp);
    return resp;
  }

  // Future<int> deleteApi(int id) async {
  //   final db = await database;
  //   final resp = await db.delete('TiposApi', where: 'id =?', whereArgs: [id]);
  //   print(resp);
  //   return resp;
  // }

  Future<int> deleteApi(String tipo, String nombreApi) async {
    final db = await database;
    final resp = await db.query('TiposApi',
        where: 'tipo =? and nombreApi= ?', whereArgs: [tipo, nombreApi]);

    //     final resp2 = await db.delete('TiposApi', where: 'id =?', whereArgs: [id]);
    print(resp);
    return 1;
  }

  Future<List<Map<String, Object>>> getAllRegistros() async {
    final db = await database;
    final resp = await db.query('TiposApi');

    print(resp[0]);
    return resp;
  }
}

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

    return await openDatabase(path, version: 3, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE TiposApi(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        nombre TEXT,
        grupo TEXT
        
      )
      ''');
    });
  }

  Future<int> nuevoTipo(ApiTipos nuevo) async {
    final db = await database;
    final resp = await db.insert('TiposApi', nuevo.toJson());

    return resp;
  }

  Future<int> deleteApi(String grupo, String nombreApi) async {
    final db = await database;

    ///
    /// OJO: mejorar el query para que devuelva un solo reg
    ///
    final resp =
        await db.query('TiposApi', where: ' nombre= ?', whereArgs: [nombreApi]);
    final resp2 = resp.map((s) => ApiTipos.fromJson(s)).toList();
    final row = resp2.firstWhere((element) => element.grupo == grupo);
    final result =
        await db.delete('TiposApi', where: 'id=?', whereArgs: [row.id]);

    return result;
  }

  Future<int> eliminarGrupo(String tipo) async {
    final db = await database;
    final result =
        await db.delete('TiposApi', where: 'grupo=?', whereArgs: [tipo]);
    return result;
  }

  Future<int> eliminarGrupoMP(String nombre) async {
    final db = await database;
    final result =
        await db.delete('TiposApi', where: 'grupo=?', whereArgs: [nombre]);

    return result;
  }

  Future<List<Map<String, Object>>> getAllRegistros() async {
    final db = await database;
    final resp = await db.query('TiposApi');

    return resp;
  }
}

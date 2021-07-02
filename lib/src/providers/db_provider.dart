import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrread/src/models/scan-model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT,'
          ')');
    });
  }

  //Criar registros
  novoScanRaw(ScanModel novoScan) async {
    final db = await database;

    final resp = await db.rawInsert("INSERT INTO Scans (id, tipo, valor) "
        "VALUES ( '${ novoScan.id }','${ novoScan.tipo }', '${ novoScan.valor }' )"
    );

    return resp;
  }

     //Inserir valores na Base dados

    novoScan( ScanModel novoScan ) async {

       final db = await database;
       final resp = db.insert('Scans', novoScan.toJson() ); 

       return resp;
    }

    // SELECT - Obter iformacoes da base de dados

}

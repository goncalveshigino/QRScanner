import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrread/src/models/scan-model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
 
 //Buscar na base de dados
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
   Future<ScanModel> getScanId( int id ) async {


     final db = await database;

     final resp = await db.query('Scans', where: 'id = ?', whereArgs: [id] );

      return resp.isNotEmpty ? ScanModel.fromJson( resp.first) : null;

    }


    //Pegar todos os Scan da db 
    Future<List<ScanModel>> getTodosScans() async {
      
      final db   = await database;
      final resp = await db.query('Scans'); 

      List<ScanModel> list = resp.isNotEmpty 
                               ? resp.map( (c) => ScanModel.fromJson(c)).toList()
                               : [];

      return list;                     
    } 

     //Pegar registro por tipo
     Future<List<ScanModel>> getScansTipo( String tipo) async {
      
      final db   = await database;
      final resp = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'"); 

      List<ScanModel> list = resp.isNotEmpty 
                               ? resp.map( (c) => ScanModel.fromJson(c)).toList()
                               : [];

      return list;                     
    } 


    //Atualizar Registros
   Future<int> updateScan( ScanModel novoScan) async {


       final db   = await database;
       final resp = await db.update('Scans', novoScan.toJson(), where: 'id = ?', whereArgs: [ novoScan.id ] );


       return resp;

    }


    //Eliminar registros 
   Future<int> deleteScan( int id) async {
        

        final db   = await database; 
        final resp = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

        return resp;

    }

    Future<int> deleteAll() async {


        final db   = await database;
        final resp = await db.rawDelete('DELETE FROM Scans');


        return resp;
    }




}

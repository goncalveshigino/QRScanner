import 'dart:async';

import 'package:qrread/src/providers/db_provider.dart';

class ScansBloc {
  
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Obter os Scans na base de dados
    obterScans();
  }

  final _scanController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scanController.stream;

  dispose() {
    _scanController?.close();
  } 

  //Obter todas as informacoes dos scans
  obterScans() async {
    _scanController.sink.add(await DBProvider.db.getTodosScans());
  }

  //Criar novo scan
  adicionarSCan( ScanModel scan ) async {
    
    await DBProvider.db.novoScan(scan); 
    obterScans();
  }

  //Eliminar Scan
  eliminarScan( int id) async { 
   
   await DBProvider.db.deleteScan(id); 
   obterScans();

  }

  //Eliminar todos os scans 
   eliminarTodosScans() async {

     await DBProvider.db.deleteAll(); 
     obterScans();
   }
}

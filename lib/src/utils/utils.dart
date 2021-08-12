
import 'package:flutter/material.dart';
import 'package:qrread/src/models/scan-model.dart';
import 'package:url_launcher/url_launcher.dart'; 



abrirScan( BuildContext context, ScanModel scan ) async {

  if( scan.tipo == 'http'){
     

    if( await canLaunch(scan.valor)) {
      await  launch(scan.valor);
    } else {
     throw 'Nao pode abrir ${ scan.valor }';
    }

  } else {

    Navigator.pushNamed( context, 'mapa', arguments:  scan );

  }

  

}

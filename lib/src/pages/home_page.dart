import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:qrread/src/bloc/scans_bloc.dart';
import 'package:qrread/src/models/scan-model.dart';
import 'package:qrread/src/pages/direcciones.dart';
import 'package:qrread/src/pages/maps.dart';

import 'package:qrread/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  // String _scanBarcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_forever,
            ),
            onPressed: scansBloc.eliminarTodosScans,
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.filter_center_focus,
        ),
        onPressed: () => _scanQR( context ),
      ),
    );
  }

  Future<void> _scanQR(BuildContext context) async {

    String geo = 'geo:40.724233047051705,-74.00731459101564';

    String futureString = 'https://fernando-herrera.com';

    if (futureString != null) {
      
      final scan = ScanModel(valor: futureString);
      scansBloc.adicionarSCan(scan);

      final scan2 = ScanModel(valor: geo);
      scansBloc.adicionarSCan(scan2);


      if ( Platform.isIOS ) {

        Future.delayed( Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {
        utils.abrirScan(context, scan);
      }
  
    }

    /*try {
      futureString = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR );
      print("MYQR"+futureString);
    } on PlatformException {
      futureString = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = futureString;
    });
       */
  }

  Widget _callPage(int paginaAtual) {
    switch (paginaAtual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }

  Widget _createBottomNavigationBar() {
    return CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        index: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(
            Icons.map,
            color: Colors.deepPurple,
          ),
          Icon(
            Icons.brightness_5,
            color: Colors.deepPurple,
          ),
        ]);
  }
}

import 'package:flutter/material.dart';

import 'package:qrread/src/models/scan-model.dart'; 
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';


class MapaPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
       appBar: AppBar(
         title: Text('Coodenadas QR'),
         actions: [
           IconButton(
              icon: Icon( Icons.my_location),
              onPressed: (){},
           )
         ],
       ),
       body: _criarFlutterMap( scan )
    );
  }



  Widget _criarFlutterMap( ScanModel scan ){

   return FlutterMap(
     options: MapOptions(
       center: scan.getLatLng(),
       zoom: 10
     ),
     layers: [
       _criarMapa(),
     ],
   );

  }


  _criarMapa(){

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiaGlnaW5vIiwiYSI6ImNrczhua2s5czM5emsyeG1zd3AxZ3hsYW8ifQ.lxdR0GV2Bq8rmrTEyGK7PA',
        'id': 'mapbox.streets'
      }
    );

  }

}
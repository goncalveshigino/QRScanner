import 'package:flutter/material.dart';
import 'package:qrread/src/models/scan-model.dart';
import 'package:qrread/src/providers/db_provider.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(

        future: DBProvider.db.getTodosScans(),
        builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('Nao ha informacao'),
            );
          }


          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: ( context, i) => Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              onDismissed: ( direction ) => DBProvider.db.deleteScan( scans[i].id),
              background: Container( color: Colors.red),
              child: ListTile(
                leading: Icon( Icons.cloud_queue, color: Theme.of(context).primaryColor),
                title: Text( scans[i].valor),
                subtitle: Text( 'ID: ${ scans[i].id }'),
                trailing: Icon( Icons.keyboard_arrow_down, color: Colors.grey ),
              ),
            ),
          );



        }
      );
  }
}

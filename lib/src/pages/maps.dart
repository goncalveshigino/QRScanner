import 'package:flutter/material.dart';
import 'package:qrread/src/bloc/scans_bloc.dart';
import 'package:qrread/src/models/scan-model.dart';
import 'package:qrread/src/providers/db_provider.dart';

class MapasPage extends StatelessWidget {

   final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(

        stream: scansBloc.scansStream,
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
            physics: BouncingScrollPhysics(),
            itemCount: scans.length,
            itemBuilder: ( context, i) => Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              background: Container( color: Colors.red),
              onDismissed: ( direction ) => scansBloc.eliminarScan(scans[i].id),
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

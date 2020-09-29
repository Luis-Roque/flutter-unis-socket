import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unis_name/src/service/socket_service.dart';

class statusPage extends StatelessWidget {
  const statusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final socketService= Provider.of<SocketService>(context);
    
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('ServerStatus: ${socketService.serverStatus}')
        ],
      )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: (){
          
          socketService.socket.emit('emitir-mensaje',{
            'nombre':'Luis',
            'mensaje': 'Becas Benito'
          });
        }),
    );
  }
}
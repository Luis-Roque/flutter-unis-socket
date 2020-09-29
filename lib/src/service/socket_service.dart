import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
    Online,
    Offline,
    Connecting
  }

class SocketService with ChangeNotifier{

ServerStatus _serverStatus =ServerStatus.Connecting;
IO.Socket _socket;

ServerStatus get serverStatus => this. _serverStatus;
IO.Socket get socket => this._socket;

  SocketService(){
    this._initConfig();
}  

void _initConfig(){
  //DART client
  this._socket = IO.io('http://localhost:3000/',{
    'transports':['websocket'],
    'autoConnect':true
  });
    this._socket.on('connect', (_) {
     this._serverStatus= ServerStatus.Online;
     notifyListeners();
    });
    this._socket.on('disconnect', (_) {
      this._serverStatus= ServerStatus.Offline;
     notifyListeners();
    });
    //socket.on('nuevo-mensaje', (payload) {
      //print('nuevo-mensaje:');
      //print('nombre:'+ payload['nombre']);
      //print('mensaje:'+ payload['mensaje']);
      //print(payload.containsKey('mensaje2') ? payload['mensaje2']:'sin mensaje');
    //});
    
}

}
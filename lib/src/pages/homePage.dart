import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:unis_name/src/models/unis.dart';
import 'package:unis_name/src/service/socket_service.dart';

class homePage extends StatefulWidget {
  const homePage({Key key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Uni> unis=[
    //Unis(id: '1', nombre: 'UICSLP', votos: 10),
    //Unis(id: '2', nombre: 'ITST', votos: 14),
    //Unis(id: '3', nombre: 'UASLP', votos: 20),
  ];
@override
void initState() { 

   final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('unis-activas', _handleUnisActivas);
  super.initState();
}
_handleUnisActivas(dynamic payload){
  this.unis= (payload as List)
      .map((uni) => Uni.fromMap(uni))
      .toList();
  setState(() { });

}
@override
  void dispose() {
    // TODO: implement dispose
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('unis-activas');
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades', style: TextStyle(color:Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus== ServerStatus.Online)
            ? Icon(Icons.wifi, color: Colors.green,)
            : Icon(Icons.signal_wifi_off, color: Colors.red,)
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _crearGrafica(),
          Expanded(
            child: ListView.builder(
              itemCount: unis.length,
              itemBuilder: (context,i) => _unisTile(unis[i])
            ),
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.school),
          elevation: 1,
          onPressed: nuevaUni
          ),
    );
  }

  Widget _unisTile(Uni uni) {
    final socketService= Provider.of<SocketService>(context,listen: false);
    return Dismissible(
          key: Key(uni.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (_)=>socketService.socket.emit('borrar',{'id':uni.id}),
          background: Container(
            padding: EdgeInsets.only(left:8.0),
            color: Colors.orange[800],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Borrar Universidad', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                 

              ),
              ),
            )
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text(uni.nombre.substring(0,2)),
            backgroundColor: Colors.blue[600],
            ),
            title: Text(uni.nombre),
            trailing: Text('${uni.votos}'),
            onTap: ()=>socketService.socket.emit('voto',{'id':uni.id}),
          ),
    );
  }
  
  nuevaUni(){

    final textController = new TextEditingController();
    if (Platform.isAndroid){
      //ANDROID
    return showDialog(
     context: context,
     builder: (_)=> AlertDialog(
       title: Text('Nueva universidad:'),
       content: TextField(controller: textController,),
       actions: <Widget>[
         MaterialButton(
           child: Text('Agregar'),
           elevation: 5,
           textColor: Colors.blue[600],
           onPressed: ()=> agregarUniToList(textController.text)
           )
       ],
       )
     );
    }
    showCupertinoDialog(
      context: context,
      builder: (_)=> CupertinoAlertDialog(
          title: Text('Nueva universidad:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Agregar'),
              onPressed: () => agregarUniToList(textController.text),
              ),
              CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
              )
          ],
        )
      );
  }

  void agregarUniToList (String nombre){
   
   final socketService = Provider.of<SocketService>(context,listen: false);
    if (nombre.length > 1){
      //Podemos agregar
      socketService.socket.emit('nueva-uni',{'nombre':nombre});
      setState(() {});
    }
    Navigator.pop(context);
  }

  Widget _crearGrafica() {
    Map<String, double> dataMap = new Map(); 
    unis.forEach((uni) {
      dataMap.putIfAbsent(uni.nombre, () => uni.votos.toDouble());
     });
     
  return Container(
    padding: EdgeInsets.only(top: 10),
    height: 200,
    width: double.infinity,
    child: PieChart(dataMap: dataMap));
  }
}
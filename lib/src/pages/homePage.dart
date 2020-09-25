import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:unis_name/src/models/unis.dart';

class homePage extends StatefulWidget {
  const homePage({Key key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Unis> unis=[
    Unis(id: '1', nombre: 'UICSLP', votos: 10),
    Unis(id: '2', nombre: 'ITST', votos: 14),
    Unis(id: '3', nombre: 'UASLP', votos: 20),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades', style: TextStyle(color:Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: unis.length,
        itemBuilder: (context,i) => _unisTile(unis[i])
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.school),
          elevation: 1,
          onPressed: nuevaUni
          ),
    );
  }

  Widget _unisTile(Unis uni) {
    return Dismissible(
          key: Key(uni.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){
            print('direccion: $direction');
            print('id: ${uni.id}');
            //TODO: llamar el borrado en el server
          },
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
            onTap: (){
              print(uni.nombre);
            },
          ),
    );
  }
  
  nuevaUni(){

    final textController = new TextEditingController();
    if (Platform.isAndroid){
      //ANDROID
    return showDialog(
     context: context,
     builder: (context)=> AlertDialog(
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
      builder: (_){
        return CupertinoAlertDialog(
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
        );
      }
      );
  }

  void agregarUniToList (String nombre){
    print(nombre);

    if (nombre.length > 1){
      //Podemos agregar
      this.unis.add(new Unis(id: DateTime.now().toString(), nombre: nombre, votos: 10));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
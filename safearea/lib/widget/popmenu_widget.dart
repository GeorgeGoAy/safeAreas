  
import 'package:flutter/material.dart';

class Choice {

  const Choice( { this.title, this.icon} );

  
  final String title;
  final Icon icon;
}

const List<Choice> choices = const <Choice>[
  //const Choice(title: 'Eliminar activos', icon: Icon(Icons.delete_forever,color:Colors.black)),
  //const Choice(title: 'Configuración', icon: Icon(Icons.settings,color: Colors.black,)),
  const Choice(title: 'Log out', icon: Icon(Icons.undo,color:Colors.black)),
];




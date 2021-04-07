import 'package:exercicio_dezani/views/edita.page.dart';
import 'package:exercicio_dezani/views/lista.page.dart';
import 'package:exercicio_dezani/views/nencontrado.page.dart';
import 'package:exercicio_dezani/views/nova.page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      routes: {
        '/': (context) => ListaPage(),
        '/nova': (context) => NovaPage(),
        '/edita': (context) => EditaPage(),
        '/nencontrado':(context)=> Nencontrado(),
      },
      initialRoute: '/',
    );
  }
}

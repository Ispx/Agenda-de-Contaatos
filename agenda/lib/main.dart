import 'package:agenda/screen/contato.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AgendaApp());
}

class AgendaApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contatos",
      darkTheme: themeApp(),
      home: ContatoScreen(),
    );
  }
}

themeApp() {
  return ThemeData(
      primaryColor: Colors.grey[400],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue[400]),
      primaryColorDark: Colors.grey[400]);
}

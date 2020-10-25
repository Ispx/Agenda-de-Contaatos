import 'package:agenda/screen/contatoScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AgendaApp());
}

class AgendaApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contatos",
      darkTheme: _themeApp(),
      home: ContatoScreen(),
    );
  }
}

_themeApp() {
  return ThemeData(
      primaryColor: Colors.grey[400],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue[400]),
      primaryColorDark: Colors.grey[400]);
}

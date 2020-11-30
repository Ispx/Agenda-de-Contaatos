import 'package:agenda/models/nofitiferTheme.dart';
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
      theme: _themeApp(),
      themeMode: ThemeNotifier.getTheme(),
      darkTheme: ThemeData.dark(),
      home: ContatoScreen(),
    );
  }
}

_themeApp() {
  return ThemeData(
      primaryColor: Colors.blue[400],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue[400]),
      primaryColorDark: Colors.grey[400]);
}

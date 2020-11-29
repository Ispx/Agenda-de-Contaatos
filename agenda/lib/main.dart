import 'package:agenda/screen/contatoScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AgendaApp());
}

class AgendaApp extends StatefulWidget {
  @override
  _AgendaAppState createState() => _AgendaAppState();
}

modeThemeApp(ThemeMode theme) {
  return theme;
}

class _AgendaAppState extends State<AgendaApp> {
  ThemeMode themeMode = ThemeMode.light;
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contatos",
      theme: _themeApp(),
      themeMode: themeMode,
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

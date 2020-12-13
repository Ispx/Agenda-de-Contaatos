import 'package:agenda/models/nofitiferTheme.dart';
import 'package:agenda/screen/contatoScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (context) => ThemeNotifier(),
    child: AgendaApp(),
  ));
}

class AgendaApp extends StatelessWidget {
  Widget build(BuildContext context) {
    //print(ThemeNotifier.instance.isDarkMode);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contatos",
      theme: _themeLightApp(),
      themeMode: Provider.of<ThemeNotifier>(context, listen: true).theme,
      darkTheme: _themeDarkApp(),
      home: ContatoScreen(),
    );
  }
}

_themeLightApp() {
  return ThemeData(
      primaryColor: Colors.blue[400],
      cardColor: Colors.grey[400],
      iconTheme: IconThemeData(color: Colors.blueAccent[400]),
      textTheme: TextTheme(headline1: TextStyle(color: Colors.grey)),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue[400]),
      primaryColorDark: Colors.grey[400]);
}

_themeDarkApp() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.blueAccent[400],
      textTheme: TextTheme(
        subtitle2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white), // <-- that's the one
        headline1: TextStyle(color: Colors.white),
      ),
      cardColor: Colors.grey[900]);
}

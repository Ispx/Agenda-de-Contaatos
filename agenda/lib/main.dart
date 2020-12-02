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
      theme: _themeApp(),
      themeMode: Provider.of<ThemeNotifier>(context, listen: true).theme,
      darkTheme: darkTheme,
      home: ContatoScreen(),
    );
  }
}

_themeApp() {
  return ThemeData(
      primaryColor: Colors.blue[400],
      cardColor: Colors.grey[400],
      iconTheme: IconThemeData(color: Colors.blueAccent[400]),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue[400]),
      primaryColorDark: Colors.grey[400]);
}

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.blueAccent[400],
  appBarTheme: AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.black,
    primaryVariant: Colors.black,
    secondary: Colors.blueAccent[400],
  ),
  cardColor: Colors.black,
  iconTheme: IconThemeData(
    color: Colors.white54,
  ),
  textTheme: TextTheme(
    title: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
    subtitle: TextStyle(
      color: Colors.white70,
      fontSize: 18.0,
    ),
  ),
);

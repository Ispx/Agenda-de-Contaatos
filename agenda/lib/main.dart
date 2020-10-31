import 'package:agenda/screen/contatoScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      primaryColor: Colors.brown[900],
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue[400]),
      primaryColorDark: Colors.grey[400]);
}

_makingPhoneCall() async {
  const url = 'tel:9876543210';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Geeks for Geeks'),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 250.0,
                ),
                Text(
                  'Welcome to GFG!',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                Text(
                  'For further Updates',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: _makingPhoneCall,
                  child: Text('Call'),
                  textColor: Colors.black,
                  padding: const EdgeInsets.all(5.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

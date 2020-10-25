import 'package:agenda/database/contatosFactory.dart';
import 'package:agenda/models/contato.dart';
import 'package:agenda/screen/contatoScreen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FormularioScreen extends StatefulWidget {
  BuildContext buildContext;
  FormularioScreen();
  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _numeroController = new TextEditingController();
  FormularioState createState() => FormularioState();
}

class FormularioState extends State<FormularioScreen> {
  GlobalKey scaffoldkey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext contextForm) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar contato",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            _nomeForm('Nome', TextInputType.text),
            _numeroForm('Número', TextInputType.number),
            _buttonForm('Salvar', contextForm)
          ],
        ),
      ),
    );
  }

  _validaContato(String nome, String numero) {
    bool verify = nome != null && nome != "" && numero != null && numero != "";
    return verify;
  }

  _nomeForm(String text, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: inputType,
        controller: widget._nomeController,
        decoration: InputDecoration(
          labelText: text,
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
        ),
      ),
    );
  }

  _numeroForm(String text, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: inputType,
        controller: widget._numeroController,
        decoration: InputDecoration(
            labelText: text,
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
            hintText: 'XX  XXXX - XXXX',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[400])),
      ),
    );
  }

  _norificacao(String text, Icon icon) {
    return SnackBar(
      content: Row(
        children: [
          icon,
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.blue,
    );
  }

  _buttonForm(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {
          String nome = widget._nomeController.text;
          String numero = widget._numeroController.text;
          if (_validaContato(nome, numero)) {
            ContatoFactory().salvar(Contato(nome, numero)).whenComplete(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ContatoScreen()),
                  (route) => false);
            });
          }
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2),
        ),
        color: Colors.green[900],
        padding: EdgeInsets.only(left: 120, right: 120, bottom: 15, top: 15),
      ),
    );
  }
}

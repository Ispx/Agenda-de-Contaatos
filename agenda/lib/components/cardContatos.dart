import 'package:url_launcher/url_launcher.dart';
import 'package:agenda/database/contatosFactory.dart';
import 'package:agenda/models/contato.dart';
import 'package:agenda/screen/contatoScreen.dart';
import 'package:agenda/screen/formularioScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget cardContatos(Contato contato, BuildContext context) {
  return Card(
    color: Colors.white,
    child: ListTile(
      leading: Material(
          child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.brown[800],
                child: Text(
                  contato.getNome().toString().substring(0, 1),
                  style: TextStyle(color: Colors.white),
                ),
              ))),
      title: Text(
        contato.getNome(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _mascara(contato.getTelefone()),
        style: TextStyle(color: Colors.black),
      ),
      trailing: Material(
        child: Container(
          color: Colors.white,
          width: 80,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _showDelete(contato, context);
                },
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.red[400],
                  size: 30,
                ),
              ),
              InkWell(
                onTap: () {
                  _fazChamada(contato.getTelefone().toString());
                },
                child: Icon(
                  Icons.call,
                  color: Colors.green[400],
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FormularioScreen(contato)));
      },
    ),
  );
}

_fazChamada(String tel) async {
  if (await canLaunch('tel:$tel')) {
    await launch('tel:$tel');
  } else {
    throw 'Falha ao tentar fazer chamada';
  }
}

_showDelete(Contato contato, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Desejá realmente exluir:'),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar")),
          FlatButton(
              onPressed: () {
                ContatoFactory().deletar(contato.getId()).whenComplete(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ContatoScreen()),
                      (route) => false);
                });
              },
              child: Text("Confirmar")),
        ],
      );
    },
  );
}

_mascara(String tel) {
  String ddd = tel.trim().substring(0, 2);
  String numInit = tel.trim().substring(2, tel.length - 4);
  String numEnd = tel.trim().substring(tel.length - 4, tel.length);
  return "($ddd) $numInit - $numEnd";
}

import 'package:agenda/components/listViewContato.dart';
import 'package:agenda/components/load.dart';
import 'package:agenda/database/contatosFactory.dart';
import 'package:agenda/models/contato.dart';
import 'package:agenda/screen/formularioScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContatoScreen extends StatefulWidget {
  ContatoScreenState createState() => ContatoScreenState();
}

class ContatoScreenState extends State<ContatoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contatos",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(bottom: 80),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: futureContato()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => FormularioScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  FutureBuilder futureContato() {
    return FutureBuilder<List<Contato>>(
      future: Future.delayed(Duration(seconds: 2))
          .then((value) => ContatoFactory().ler()),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return load();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            List<Contato> lista = snapshot.data;
            lista.forEach((element) {
              print("Nome: " + element.getNome().toString());
            });
            return ListViewContatos(lista, context);
            break;
        }
        return Center(
          child: Text(
            "Falha inesperada.",
            style: TextStyle(fontSize: 26, color: Colors.red),
          ),
        );
      },
    );
  }
}

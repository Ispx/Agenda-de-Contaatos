import 'dart:ui';

import 'package:agenda/components/listViewContato.dart';
import 'package:agenda/components/load.dart';
import 'package:agenda/database/contatosFactory.dart';
import 'package:agenda/main.dart';
import 'package:agenda/models/contato.dart';
import 'package:agenda/screen/formularioScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ContatoScreen extends StatefulWidget {
  Future<List<Contato>> futureConsultas = ContatoFactory().ler();
  ContatoScreenState createState() => ContatoScreenState();
}

class ContatoScreenState extends State<ContatoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_5),
            onPressed: () {
              setState(() {});
            },
          )
        ],
        title: Text(
          "Contatos",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constrains) => SingleChildScrollView(
          child: Column(
            children: [
              fitro(),
              Container(
                height: constrains.maxHeight - 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Colors.grey[400],
                ),
                child: futureContato(widget.futureConsultas),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => FormularioScreen(null)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  fitro() {
    TextEditingController textoFiltro = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      child: TextField(
        controller: textoFiltro,
        decoration: InputDecoration(
          suffix: Container(
            height: 28,
            width: 80,
            child: FlatButton(
              onPressed: () {
                setState(
                  () {
                    textoFiltro.text = "";
                    widget.futureConsultas = ContatoFactory().ler();
                  },
                );
              },
              child: Text(
                "Limpar",
                style: TextStyle(fontSize: 12),
              ),
              highlightColor: Colors.blue[900],
            ),
          ),
          hintText: 'Filtrar contato',
        ),
        onSubmitted: (string) {
          setState(
            () {
              if (string.trim() != "" &&
                  string.isNotEmpty &&
                  ContatoFactory().filtrar(string) != null) {
                widget.futureConsultas = ContatoFactory().filtrar(string);
                return;
              }
              widget.futureConsultas = ContatoFactory().ler();
            },
          );
        },
      ),
    );
  }

  FutureBuilder futureContato(Future<List<Contato>> consulta) {
    return FutureBuilder<List<Contato>>(
      future: Future.delayed(Duration(seconds: 2), () => consulta),
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

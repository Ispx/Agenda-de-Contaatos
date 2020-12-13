import 'dart:ui';

import 'package:agenda/components/listViewContato.dart';
import 'package:agenda/components/load.dart';
import 'package:agenda/database/contatosFactory.dart';
import 'package:agenda/models/contato.dart';
import 'package:agenda/models/nofitiferTheme.dart';
import 'package:agenda/screen/formularioScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ContatoScreen extends StatefulWidget {
  Future<List<Contato>> futureConsultas = ContatoFactory().ler();
  ContatoScreenState createState() => ContatoScreenState();
}

class ContatoScreenState extends State<ContatoScreen> {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<ThemeNotifier>(context).isDarkMode);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
              activeColor: Colors.blue[500],
              value:
                  Provider.of<ThemeNotifier>(context, listen: false).isDarkMode,
              onChanged: (statusCurrent) {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .updateTheme();
              })
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
              filtro(),
              Container(
                height: constrains.maxHeight - 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Theme.of(context).cardColor,
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

  filtro() {
    TextEditingController textoFiltro = TextEditingController();
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: TextField(
          controller: textoFiltro,
          decoration: InputDecoration(
            hintText: 'Filtrar contato',
            hintStyle:
                TextStyle(color: Theme.of(context).textTheme.headline1.color),
            suffix: Container(
              height: 28,
              width: 88,
              child: FlatButton(
                onPressed: () {
                  setState(
                    () {
                      textoFiltro.text = "";
                      widget.futureConsultas = ContatoFactory().ler();
                    },
                  );
                },
                child: Text("Limpar",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline1.color)),
                highlightColor: Colors.blue[900],
                disabledTextColor: Colors.grey,
              ),
            ),
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
        ));
  }

  FutureBuilder futureContato(Future<List<Contato>> consulta) {
    return FutureBuilder<List<Contato>>(
      future: Future.delayed(Duration(seconds: 1), () => consulta),
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

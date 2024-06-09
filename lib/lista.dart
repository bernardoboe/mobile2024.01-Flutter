import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  List<dynamic> _jogadores = [];

  Future<void> _fetchJogadores() async {
    final response = await http.get(Uri.parse('https://par-impar.glitch.me/jogadores'));

    if (response.statusCode == 200) {
      setState(() {
        _jogadores = json.decode(response.body)['jogadores'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao carregar jogadores.'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchJogadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jogadores'),
      ),
      body: ListView.builder(
        itemCount: _jogadores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_jogadores[index]['username']),
            subtitle: Text('Pontos: ${_jogadores[index]['pontos']}'),
          );
        },
      ),
    );
  }
}

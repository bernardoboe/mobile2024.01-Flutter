import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultadoScreen extends StatefulWidget {
  @override
  _ResultadoScreenState createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> {
  String? _selectedUsername1;
  String? _selectedUsername2;
  List<String> _players = [];
  String _resultado = '';

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    final response = await http.get(
      Uri.parse('https://par-impar.glitch.me/jogadores'),
    );

    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        _players = List<String>.from(data['jogadores'].map((x) => x['username']));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao buscar jogadores.'),
      ));
    }
  }

  Future<void> _jogar() async {
    final response = await http.get(
      Uri.parse(
          'https://par-impar.glitch.me/jogar/$_selectedUsername1/$_selectedUsername2'),
    );

    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        _resultado = 'Vencedor: ${data['vencedor']['username']} com ${data['vencedor']['valor']} pontos';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao efetuar o jogo.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedUsername1,
              hint: Text('Selecione o Jogador 1'),
              onChanged: (newValue) => setState(() {
                _selectedUsername1 = newValue;
              }),
              items: _players.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButtonFormField<String>(
              value: _selectedUsername2,
              hint: Text('Selecione o Jogador 2'),
              onChanged: (newValue) => setState(() {
                _selectedUsername2 = newValue;
              }),
              items: _players.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _jogar,
              child: Text('Jogar'),
            ),
            SizedBox(height: 20),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}

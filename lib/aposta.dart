import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApostaScreen extends StatefulWidget {
  @override
  _ApostaScreenState createState() => _ApostaScreenState();
}

class _ApostaScreenState extends State<ApostaScreen> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  String _parImpar = '2';
  String? _selectedUsername;

  List<String> _players = [];

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    final response = await http.get(Uri.parse('https://par-impar.glitch.me/jogadores'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _players = List<String>.from(data['jogadores'].map((player) => player['username']));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao buscar jogadores.'),
      ));
    }
  }

  Future<void> _efetuarAposta() async {
    final response = await http.post(
      Uri.parse('https://par-impar.glitch.me/aposta'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': _selectedUsername,
        'valor': int.parse(_valorController.text),
        'parimpar': int.parse(_parImpar),
        'numero': int.parse(_numeroController.text),
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Aposta realizada com sucesso!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao realizar aposta.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Efetuar Aposta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedUsername,
              hint: Text('Selecione o jogador'),
              onChanged: (newValue) {
                setState(() {
                  _selectedUsername = newValue;
                });
              },
              items: _players.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor da Aposta'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _numeroController,
              decoration: InputDecoration(labelText: 'Número (1-5)'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _parImpar,
              items: [
                DropdownMenuItem(
                  value: '2',
                  child: Text('Par'),
                ),
                DropdownMenuItem(
                  value: '1',
                  child: Text('Ímpar'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _parImpar = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedUsername != null ? _efetuarAposta : null,
              child: Text('Apostar'),
            ),
          ],
        ),
      ),
    );
  }
}

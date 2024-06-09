import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _usernameController = TextEditingController();

  Future<void> _cadastrarJogador() async {
    final response = await http.post(
      Uri.parse('https://par-impar.glitch.me/novo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Jogador cadastrado com sucesso!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao cadastrar jogador.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Jogador'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nome do Jogador'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cadastrarJogador,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

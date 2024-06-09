import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'lista.dart';
import 'aposta.dart';
import 'resultado.dart';

void main() {
  runApp(ParOuImparApp());
}

class ParOuImparApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Par ou Ímpar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Par ou Ímpar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()),
                );
              },
              child: Text('Cadastrar Jogador'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaScreen()),
                );
              },
              child: Text('Listar Jogadores'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApostaScreen()),
                );
              },
              child: Text('Efetuar Aposta'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultadoScreen()),
                );
              },
              child: Text('Selecionar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}

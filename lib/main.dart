import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: JogoDaVelhaPage(),
    );
  }
}

class JogoDaVelhaPage extends StatefulWidget {
  @override
  _JogoDaVelhaPageState createState() => _JogoDaVelhaPageState();
}

class _JogoDaVelhaPageState extends State<JogoDaVelhaPage> {
  List<List<String>> _tabuleiro = List.generate(3, (_) => List.filled(3, ''));
  bool _isXTurn = true;
  String _winner = '';

  void _reiniciarJogo() {
    setState(() {
      _tabuleiro = List.generate(3, (_) => List.filled(3, ''));
      _isXTurn = true;
      _winner = '';
    });
  }

  void _jogar(int i, int j) {
    if (_tabuleiro[i][j].isEmpty && _winner.isEmpty) {
      setState(() {
        _tabuleiro[i][j] = _isXTurn ? 'X' : 'O';
        _isXTurn = !_isXTurn;
      });

      _verificarVencedor();
    }
  }

  void _verificarVencedor() {
    // Verificando linhas e colunas
    for (int i = 0; i < 3; i++) {
      if (_tabuleiro[i][0] == _tabuleiro[i][1] &&
          _tabuleiro[i][1] == _tabuleiro[i][2] &&
          _tabuleiro[i][0] != '') {
        setState(() {
          _winner = _tabuleiro[i][0];
        });
        return;
      }
      if (_tabuleiro[0][i] == _tabuleiro[1][i] &&
          _tabuleiro[1][i] == _tabuleiro[2][i] &&
          _tabuleiro[0][i] != '') {
        setState(() {
          _winner = _tabuleiro[0][i];
        });
        return;
      }
    }

    // Verificando diagonais
    if (_tabuleiro[0][0] == _tabuleiro[1][1] &&
        _tabuleiro[1][1] == _tabuleiro[2][2] &&
        _tabuleiro[0][0] != '') {
      setState(() {
        _winner = _tabuleiro[0][0];
      });
      return;
    }
    if (_tabuleiro[0][2] == _tabuleiro[1][1] &&
        _tabuleiro[1][1] == _tabuleiro[2][0] &&
        _tabuleiro[0][2] != '') {
      setState(() {
        _winner = _tabuleiro[0][2];
      });
      return;
    }

    // Verificando empate
    bool empate = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_tabuleiro[i][j] == '') {
          empate = false;
          break;
        }
      }
    }

    if (empate) {
      setState(() {
        _winner = 'Empate';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reiniciarJogo,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_winner.isNotEmpty)
            Text(
              _winner == 'Empate' ? 'Empate!' : 'Jogador $_winner venceu!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 20),
          Column(
            children: List.generate(3, (i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (j) {
                  return GestureDetector(
                    onTap: () => _jogar(i, j),
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _tabuleiro[i][j],
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: _tabuleiro[i][j] == 'X' ? Colors.blue : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
          SizedBox(height: 20),
          Text(
            _isXTurn ? 'Vez do X' : 'Vez do O',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

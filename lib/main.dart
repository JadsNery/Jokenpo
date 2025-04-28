import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JokenpoGame(),
    );
  }
}

class JokenpoGame extends StatefulWidget {
  @override
  _JokenpoGameState createState() => _JokenpoGameState();
}

class _JokenpoGameState extends State<JokenpoGame> {
  int escolhaJogador = 0; // Armazena a escolha do jogador (1 = Pedra, 2 = Papel, 3 = Tesoura).
  int escolhaComputador = 0; // Armazena a escolha da máquina.
  String resultado = ""; // Armazena o resultado da rodada.
  String jogadaComputadorExibida = ""; // Armazena a jogada da máquina para exibir.

  void _jogadaComputador() async {
    setState(() {
      resultado = ""; // Limpa o resultado anterior.
      jogadaComputadorExibida = ""; // Limpa a jogada da máquina exibida.
    });

    // Contagem regressiva de 2 segundos com suspense
    for (int i = 2; i > 0; i--) {
      setState(() {
        jogadaComputadorExibida = "Revelando em $i...";
      });
      await Future.delayed(Duration(seconds: 1)); // Aguarda 1 segundo.
    }

    // Gera a jogada da máquina após a contagem regressiva
    setState(() {
      escolhaComputador = Random().nextInt(3) + 1; // Gera um número aleatório entre 1 e 3.
      jogadaComputadorExibida = "Máquina escolheu ${_opcaoParaTexto(escolhaComputador)}";
      resultado = _verificarResultado(escolhaJogador, escolhaComputador); // Verifica quem ganhou.
    });
  }

  String _verificarResultado(int jogador, int computador) {
    if (jogador == computador) {
      return "Empate!";
    } else if ((jogador == 1 && computador == 3) || 
               (jogador == 2 && computador == 1) || 
               (jogador == 3 && computador == 2)) {
      return "Você venceu!";
    } else {
      return "Você perdeu!";
    }
  }

  String _opcaoParaTexto(int opcao) {
    switch (opcao) {
      case 1:
        return "Pedra";
      case 2:
        return "Papel";
      case 3:
        return "Tesoura";
      default:
        return "";
    }
  }

  String _imagemJogador(int escolha) {
    switch (escolha) {
      case 1:
        return "assets/images/pedra.jpeg";
      case 2:
        return "assets/images/papel.jpeg";
      case 3:
        return "assets/images/tesoura.jpeg";
      default:
        return "";
    }
  }

  String _imagemComputador(int escolha) {
    switch (escolha) {
      case 1:
        return "assets/images/pedra2.jpeg";
      case 2:
        return "assets/images/papel2.jpeg";
      case 3:
        return "assets/images/tesoura2.jpeg";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jokenpo")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Escolha sua jogada:", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        escolhaJogador = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/pedra.jpeg", width: 80, height: 80),
                        Text("PEDRA", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  SizedBox(width: 20), // Espaçamento entre os botões.
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        escolhaJogador = 2;
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/papel.jpeg", width: 80, height: 80),
                        Text("PAPEL", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  SizedBox(width: 20), // Espaçamento entre os botões.
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        escolhaJogador = 3;
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/tesoura.jpeg", width: 80, height: 80),
                        Text("TESOURA", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (escolhaJogador != 0) {
                    _jogadaComputador();
                  }
                },
                child: Text("PLAY"),
              ),
              SizedBox(height: 20),
              Text("Sua escolha: ${_opcaoParaTexto(escolhaJogador)}"),
              if (escolhaJogador != 0) Image.asset(_imagemJogador(escolhaJogador), width: 100, height: 100),
              SizedBox(height: 20), 
              Text(jogadaComputadorExibida),
              if (escolhaComputador != 0) Image.asset(_imagemComputador(escolhaComputador), width: 100, height: 100),
              SizedBox(height: 20),
              Text("Resultado: $resultado", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
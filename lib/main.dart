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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jokenpo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Escolha sua jogada:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      escolhaJogador = 1;
                    });
                  },
                  child: Text("Pedra", style: TextStyle(fontSize: 20)),
                ),
                SizedBox(width: 20), // Espaçamento entre os botões.
                GestureDetector(
                  onTap: () {
                    setState(() {
                      escolhaJogador = 2;
                    });
                  },
                  child: Text("Papel", style: TextStyle(fontSize: 20)),
                ),
                SizedBox(width: 20), // Espaçamento entre os botões.
                GestureDetector(
                  onTap: () {
                    setState(() {
                      escolhaJogador = 3;
                    });
                  },
                  child: Text("Tesoura", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (escolhaJogador != 0) {
                  _jogadaComputador();
                }
              },
              child: Text("Jogar"),
            ),
            Text("Sua escolha: ${_opcaoParaTexto(escolhaJogador)}"),
            Text(jogadaComputadorExibida),
            Text("Resultado: $resultado"),
          ],
        ),
      ),
    );
  }
}
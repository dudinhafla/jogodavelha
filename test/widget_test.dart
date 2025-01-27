import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jogo_da_velha_flutter/main.dart'; // Caminho para o arquivo main.dart

void main() {
  testWidgets('Testar alternância de turnos', (WidgetTester tester) async {
    await tester.pumpWidget(JogoDaVelhaApp());

    // Verificar se o jogo começa com o jogador X
    expect(find.text('Vez do X'), findsOneWidget);
    expect(find.text('Vez do O'), findsNothing);

    // Fazer uma jogada
    await tester.tap(find.text(''));
    await tester.pump();

    // Verificar se o turno mudou para O
    expect(find.text('Vez do X'), findsNothing);
    expect(find.text('Vez do O'), findsOneWidget);
  });

  testWidgets('Testar vencedor X na linha', (WidgetTester tester) async {
    await tester.pumpWidget(JogoDaVelhaApp());

    // Fazer jogadas para formar uma linha de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de O
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de O
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X

    // Verificar se o jogador X venceu
    expect(find.text('Jogador X venceu!'), findsOneWidget);
  });

  testWidgets('Testar empate', (WidgetTester tester) async {
    await tester.pumpWidget(JogoDaVelhaApp());

    // Fazer jogadas para causar um empate
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de O
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de O
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de O
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de O

    // Verificar se o jogo terminou em empate
    expect(find.text('Empate!'), findsOneWidget);
  });

  testWidgets('Testar reiniciar o jogo', (WidgetTester tester) async {
    await tester.pumpWidget(JogoDaVelhaApp());

    // Fazer algumas jogadas
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de X
    await tester.tap(find.text(''));
    await tester.pump(); // Jogada de O

    // Verificar se o jogo está em andamento
    expect(find.text('Vez do X'), findsOneWidget);

    // Reiniciar o jogo
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    // Verificar se o jogo foi reiniciado
    expect(find.text('Vez do X'), findsOneWidget);
    expect(find.text('Vez do O'), findsNothing);
  });
}

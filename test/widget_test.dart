import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:old_world_companion/main.dart';
import 'package:old_world_companion/screens/rolls_screen.dart';

void main() {
  testWidgets('muestra las seis herramientas del menú', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OldWorldCompanionApp());

    expect(find.text('Cuaderno de batalla'), findsOneWidget);
    expect(find.text('Resultados de Combate'), findsOneWidget);
    expect(find.text('Puntos de Victoria'), findsOneWidget);
    expect(find.text('Impactar/Herir'), findsOneWidget);
    expect(find.text('Magos'), findsOneWidget);
    expect(find.text('Fases'), findsOneWidget);

    await tester.drag(find.byType(Scrollable), const Offset(0, -500));
    await tester.pump();

    expect(find.text('Preferencias'), findsOneWidget);
  });

  testWidgets('el menú abre la pantalla de combate', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OldWorldCompanionApp());

    await tester.tap(find.text('Resultados de Combate'));
    await tester.pumpAndSettle();

    expect(find.text('Calcular Resultados de Combate'), findsOneWidget);
    expect(find.text('Atacante'), findsOneWidget);
    expect(find.text('Defensor'), findsOneWidget);
  });

  testWidgets('la pantalla de impactos permite elegir disparo', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OldWorldCompanionApp());

    await tester.tap(find.text('Impactar/Herir'));
    await tester.pumpAndSettle();

    expect(find.text('Combate'), findsOneWidget);
    expect(find.text('Disparo'), findsOneWidget);

    await tester.tap(find.text('Disparo'));
    await tester.pump();

    expect(find.text('Habilidad balística (BS)'), findsOneWidget);
    expect(find.text('Otros'), findsOneWidget);
    expect(find.text('Reiniciar'), findsOneWidget);
  });

  test('calcula las tiradas de impactar', () {
    expect(calculateHitTarget(7, 3), '2+');
    expect(calculateHitTarget(5, 3), '3+');
    expect(calculateHitTarget(3, 3), '4+');
    expect(calculateHitTarget(2, 5), '5+');
  });

  test('calcula las tiradas de disparo y sus modificadores', () {
    expect(calculateShootingTarget(1, 0), '6+');
    expect(calculateShootingTarget(5, 0), '2+');
    expect(calculateShootingTarget(6, 0), '2+/6+');
    expect(calculateShootingTarget(10, 0), '2+/2+');
    expect(calculateShootingTarget(5, -1), '3+');
    expect(calculateShootingTarget(1, -1), '6/4+');
    expect(calculateShootingTarget(1, -2), '6/5+');
    expect(calculateShootingTarget(1, -3), '6/6');
    expect(calculateShootingTarget(1, -4), 'Imposible');
    expect(calculateShootingTarget(1, 10), '2+');
  });

  test('calcula las tiradas de herir', () {
    expect(calculateWoundTarget(4, 3), '3+');
    expect(calculateWoundTarget(5, 3), '2+');
    expect(calculateWoundTarget(4, 4), '4+');
    expect(calculateWoundTarget(3, 4), '5+');
    expect(calculateWoundTarget(2, 4), '6+');
    expect(calculateWoundTarget(1, 7), 'Imposible');
    expect(calculateWoundTarget(10, 1), '2+');
  });
}

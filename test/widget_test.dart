import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:old_world_companion/main.dart';

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
}

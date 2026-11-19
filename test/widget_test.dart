import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:old_world_companion/main.dart';
import 'package:old_world_companion/screens/combat_screen.dart';
import 'package:old_world_companion/theme/app_appearance.dart';
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

  testWidgets('el selector de apariencia se actualiza al elegir un color', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OldWorldCompanionApp());

    await tester.drag(find.byType(Scrollable), const Offset(0, -500));
    await tester.pump();
    await tester.tap(find.text('Preferencias'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Middenland'));
    await tester.pump();

    final theme = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme;
    expect(theme?.colorScheme.primary, AppAppearance.middenland.accent);
    final selectedRadio = tester.widget<Radio<AppAppearance>>(
      find.byType(Radio<AppAppearance>).at(1),
    );
    // ignore: deprecated_member_use
    final selectedAppearance = selectedRadio.groupValue;
    expect(selectedAppearance, AppAppearance.middenland);
  });

  testWidgets('los bonos únicos son checkboxes y se pueden reiniciar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const OldWorldCompanionApp());

    await tester.tap(find.text('Resultados de Combate'));
    await tester.pumpAndSettle();

    expect(find.byType(CheckboxListTile), findsNWidgets(8));
    expect(find.text('Reiniciar'), findsOneWidget);

    final firstCheckbox = find.byType(CheckboxListTile).first;
    await tester.tap(firstCheckbox);
    await tester.pump();
    expect(tester.widget<CheckboxListTile>(firstCheckbox).value, isTrue);

    await tester.drag(find.byType(Scrollable), const Offset(0, -1000));
    await tester.pump();
    await tester.tap(find.text('Reiniciar'));
    await tester.pump();
    expect(tester.widget<CheckboxListTile>(firstCheckbox).value, isFalse);
  });

  test('calcula el vencedor, la diferencia y los empates', () {
    final attackerWins = calculateCombatResult(5, 2);
    expect(attackerWins.winner, CombatWinner.attacker);
    expect(attackerWins.difference, 3);

    final defenderWins = calculateCombatResult(2, 5);
    expect(defenderWins.winner, CombatWinner.defender);
    expect(defenderWins.difference, 3);

    final draw = calculateCombatResult(4, 4);
    expect(draw.winner, CombatWinner.draw);
    expect(draw.difference, 0);
  });

  test('calcula los rangos de Liderazgo', () {
    final targets = calculateLeadershipTargets(leadership: 8, difference: 2);

    expect(targets.groundHeld, '2–6');
    expect(targets.orderlyRetreat, '7–8');
    expect(targets.flee, '9–12');

    final lowLeadership = calculateLeadershipTargets(
      leadership: 1,
      difference: 0,
    );
    expect(lowLeadership.groundHeld, 'Imposible');
    expect(lowLeadership.orderlyRetreat, 'Imposible');
    expect(lowLeadership.flee, '2–12');

    final highLeadership = calculateLeadershipTargets(
      leadership: 20,
      difference: 2,
    );
    expect(highLeadership.groundHeld, '2–12');
    expect(highLeadership.orderlyRetreat, 'Imposible');
    expect(highLeadership.flee, 'Imposible');
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

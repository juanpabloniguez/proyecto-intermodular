import 'package:flutter/material.dart';

import '../widgets/base_screen.dart';

const _combatBonuses = [
  'Estandarte',
  'Estandarte de Batalla',
  'Formación Cerrada',
  'Infantería Concentrada',
  'Heridas sin Salvar',
  'Bono por Filas',
  'Otros',
];

const _singleBonuses = [
  'Estandarte',
  'Estandarte de Batalla',
  'Formación Cerrada',
  'Infantería Concentrada',
];

enum CombatWinner { attacker, defender, draw }

class CombatResult {
  const CombatResult({required this.winner, required this.difference});

  final CombatWinner winner;
  final int difference;
}

CombatResult calculateCombatResult(int attackerScore, int defenderScore) {
  final difference = (attackerScore - defenderScore).abs();
  if (attackerScore == defenderScore) {
    return CombatResult(winner: CombatWinner.draw, difference: difference);
  }
  return CombatResult(
    winner: attackerScore > defenderScore
        ? CombatWinner.attacker
        : CombatWinner.defender,
    difference: difference,
  );
}

class LeadershipTargets {
  const LeadershipTargets({
    required this.groundHeld,
    required this.orderlyRetreat,
    required this.flee,
  });

  final String groundHeld;
  final String orderlyRetreat;
  final String flee;
}

LeadershipTargets calculateLeadershipTargets({
  required int leadership,
  required int difference,
}) {
  final groundHeldMaximum = leadership - difference;
  return LeadershipTargets(
    groundHeld: _formatLeadershipRange(
      2,
      groundHeldMaximum < 12 ? groundHeldMaximum : 12,
    ),
    orderlyRetreat: _formatLeadershipRange(
      groundHeldMaximum + 1 > 2 ? groundHeldMaximum + 1 : 2,
      leadership < 12 ? leadership : 12,
    ),
    flee: _formatLeadershipRange(leadership + 1 > 2 ? leadership + 1 : 2, 12),
  );
}

String _formatLeadershipRange(int minimum, int maximum) {
  if (minimum > maximum) {
    return 'Imposible';
  }
  if (minimum == maximum) {
    return '$minimum';
  }
  return '$minimum–$maximum';
}

class CombatScreen extends StatefulWidget {
  const CombatScreen({super.key});

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  final _attackerBonuses = {for (final bonus in _combatBonuses) bonus: 0};
  final _defenderBonuses = {for (final bonus in _combatBonuses) bonus: 0};

  int get _attackerScore =>
      _attackerBonuses.values.fold(0, (total, value) => total + value);

  int get _defenderScore =>
      _defenderBonuses.values.fold(0, (total, value) => total + value);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Calcular Resultados de Combate',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SectionIntro(
            title: 'Combate',
            description:
                'Añade los bonos de cada bando y calcula el resultado.',
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ScoreColumn(
                  label: 'Atacante',
                  values: _attackerBonuses,
                  onCheckboxChanged: (bonus, selected) => setState(
                    () => _attackerBonuses[bonus] = selected ? 1 : 0,
                  ),
                  onBonusPressed: (bonus) => setState(
                    () =>
                        _attackerBonuses[bonus] = _attackerBonuses[bonus]! + 1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ScoreColumn(
                  label: 'Defensor',
                  values: _defenderBonuses,
                  onCheckboxChanged: (bonus, selected) => setState(
                    () => _defenderBonuses[bonus] = selected ? 1 : 0,
                  ),
                  onBonusPressed: (bonus) => setState(
                    () =>
                        _defenderBonuses[bonus] = _defenderBonuses[bonus]! + 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => _CombatResultScreen(
                    result: calculateCombatResult(
                      _attackerScore,
                      _defenderScore,
                    ),
                  ),
                ),
              );
            },
            child: const Text('Calcular'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _resetScores,
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  void _resetScores() {
    setState(() {
      for (final bonus in _combatBonuses) {
        _attackerBonuses[bonus] = 0;
        _defenderBonuses[bonus] = 0;
      }
    });
  }
}

class _SectionIntro extends StatelessWidget {
  const _SectionIntro({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(description),
      ],
    );
  }
}

class _ScoreColumn extends StatelessWidget {
  const _ScoreColumn({
    required this.label,
    required this.values,
    required this.onCheckboxChanged,
    required this.onBonusPressed,
  });

  final String label;
  final Map<String, int> values;
  final void Function(String bonus, bool selected) onCheckboxChanged;
  final ValueChanged<String> onBonusPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final total = values.values.fold(0, (sum, value) => sum + value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$total',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 8),
        for (final bonus in _combatBonuses) ...[
          if (_singleBonuses.contains(bonus))
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(bonus),
              value: values[bonus] == 1,
              onChanged: (selected) =>
                  onCheckboxChanged(bonus, selected == true),
            )
          else
            OutlinedButton(
              onPressed: () => onBonusPressed(bonus),
              child: Text(bonus),
            ),
          Text(
            '${values[bonus]}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 6),
        ],
      ],
    );
  }
}

class _CombatResultScreen extends StatefulWidget {
  const _CombatResultScreen({required this.result});

  final CombatResult result;

  @override
  State<_CombatResultScreen> createState() => _CombatResultScreenState();
}

class _CombatResultScreenState extends State<_CombatResultScreen> {
  int? _leadership;

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    return BaseScreen(
      title: 'Resultado del Combate',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    result.winner == CombatWinner.draw
                        ? 'Empate'
                        : result.winner == CombatWinner.attacker
                        ? 'Ha ganado el Atacante'
                        : 'Ha ganado el Defensor',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text('Diferencia: ${result.difference}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Liderazgo',
              hintText: 'Introduce el Liderazgo',
            ),
            onChanged: (value) => setState(() {
              _leadership = int.tryParse(value);
            }),
          ),
          if (_leadership != null && result.winner != CombatWinner.draw) ...[
            const SizedBox(height: 20),
            _LeadershipResults(
              targets: calculateLeadershipTargets(
                leadership: _leadership!,
                difference: result.difference,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LeadershipResults extends StatelessWidget {
  const _LeadershipResults({required this.targets});

  final LeadershipTargets targets;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resultados de Liderazgo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _LeadershipRow(label: 'Cede Terreno', target: targets.groundHeld),
            _LeadershipRow(
              label: 'Retirada en Buen Orden',
              target: targets.orderlyRetreat,
            ),
            _LeadershipRow(label: 'Huida', target: targets.flee),
          ],
        ),
      ),
    );
  }
}

class _LeadershipRow extends StatelessWidget {
  const _LeadershipRow({required this.label, required this.target});

  final String label;
  final String target;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label)),
          const SizedBox(width: 12),
          Text(target, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

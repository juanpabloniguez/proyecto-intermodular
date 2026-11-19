import 'package:flutter/material.dart';

import '../widgets/base_screen.dart';

String calculateHitTarget(int attackerWeaponSkill, int defenderWeaponSkill) {
  if (attackerWeaponSkill > defenderWeaponSkill * 2) {
    return '2+';
  }
  if (attackerWeaponSkill > defenderWeaponSkill) {
    return '3+';
  }
  if (defenderWeaponSkill > attackerWeaponSkill * 2) {
    return '5+';
  }
  return '4+';
}

String calculateShootingTarget(int ballisticSkill, int modifier) {
  final firstTarget = ballisticSkill <= 1
      ? 6
      : ballisticSkill <= 5
      ? 7 - ballisticSkill
      : 2;
  final modifiedTarget = firstTarget - modifier;
  final minimumTarget = modifiedTarget.clamp(2, 10);

  if (minimumTarget <= 6) {
    if (ballisticSkill >= 6) {
      final secondTarget = 12 - ballisticSkill;
      return '$minimumTarget+/$secondTarget+';
    }
    return '$minimumTarget+';
  }

  return switch (minimumTarget) {
    7 => '6/4+',
    8 => '6/5+',
    9 => '6/6',
    _ => 'Imposible',
  };
}

String calculateWoundTarget(int attackerStrength, int defenderToughness) {
  final favorableDifference = attackerStrength - defenderToughness;
  if (favorableDifference > 1) {
    return '2+';
  }
  if (favorableDifference == 1) {
    return '3+';
  }

  final difference = defenderToughness - attackerStrength;
  if (difference >= 6) {
    return 'Imposible';
  }
  if (difference <= 0) {
    return '4+';
  }
  return '${(4 + difference).clamp(2, 6)}+';
}

class RollsScreen extends StatelessWidget {
  const RollsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'Impactar / Herir',
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Impactar'),
                Tab(text: 'Herir'),
              ],
            ),
            SizedBox(
              height: 620,
              child: TabBarView(
                children: [
                  _HitView(),
                  _RollView(
                    firstLabel: 'F atacante',
                    secondLabel: 'R defensor',
                    calculateTarget: calculateWoundTarget,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _HitType { combat, shooting }

class _HitView extends StatefulWidget {
  const _HitView();

  @override
  State<_HitView> createState() => _HitViewState();
}

class _HitViewState extends State<_HitView> {
  _HitType _hitType = _HitType.combat;
  int _ballisticSkill = 1;
  final Set<String> _selectedModifiers = {};
  int _otherModifier = 0;

  int get _modifier {
    const modifierValues = {
      'Mover y disparar': -1,
      'Larga distancia': -1,
      'Aguantar y disparar': -1,
      'Cobertura parcial': -1,
      'Cobertura completa': -2,
    };
    return _selectedModifiers.fold(
      _otherModifier,
      (total, modifier) => total + modifierValues[modifier]!,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hitType == _HitType.combat) {
      return Column(
        children: [
          _RollForm(
            firstLabel: 'HA atacante',
            secondLabel: 'HA defensor',
            calculateTarget: calculateHitTarget,
          ),
          _buildHitTypeSelector(),
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: DropdownButtonFormField<int>(
            initialValue: _ballisticSkill,
            decoration: const InputDecoration(
              labelText: 'Habilidad balística (BS)',
            ),
            items: [
              for (var skill = 1; skill <= 10; skill++)
                DropdownMenuItem(value: skill, child: Text('BS $skill')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _ballisticSkill = value);
              }
            },
          ),
        ),
        const SizedBox(height: 12),
        for (final modifier in [
          'Mover y disparar',
          'Larga distancia',
          'Aguantar y disparar',
          'Cobertura parcial',
          'Cobertura completa',
        ])
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(modifier),
            value: _selectedModifiers.contains(modifier),
            onChanged: (selected) {
              setState(() {
                if (selected == true) {
                  _selectedModifiers.add(modifier);
                } else {
                  _selectedModifiers.remove(modifier);
                }
              });
            },
          ),
        const SizedBox(height: 8),
        const Align(alignment: Alignment.centerLeft, child: Text('Otros')),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: () => setState(() => _otherModifier++),
              child: const Text('+1'),
            ),
            OutlinedButton(
              onPressed: () => setState(() => _otherModifier--),
              child: const Text('-1'),
            ),
            OutlinedButton(
              onPressed: _resetModifiers,
              child: const Text('Reiniciar'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text('TIRADA OBJETIVO', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Text(
          calculateShootingTarget(_ballisticSkill, _modifier),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 20),
        _buildHitTypeSelector(),
      ],
    );
  }

  Widget _buildHitTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _hitTypeButton(label: 'Combate', type: _HitType.combat),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _hitTypeButton(label: 'Disparo', type: _HitType.shooting),
        ),
      ],
    );
  }

  Widget _hitTypeButton({required String label, required _HitType type}) {
    final isSelected = _hitType == type;
    return isSelected
        ? FilledButton(onPressed: null, child: Text(label))
        : OutlinedButton(
            onPressed: () => setState(() => _hitType = type),
            child: Text(label),
          );
  }

  void _resetModifiers() {
    setState(() {
      _selectedModifiers.clear();
      _otherModifier = 0;
    });
  }
}

class _RollView extends StatelessWidget {
  const _RollView({
    required this.firstLabel,
    required this.secondLabel,
    required this.calculateTarget,
  });

  final String firstLabel;
  final String secondLabel;
  final String Function(int firstValue, int secondValue) calculateTarget;

  @override
  Widget build(BuildContext context) {
    return _RollForm(
      firstLabel: firstLabel,
      secondLabel: secondLabel,
      calculateTarget: calculateTarget,
    );
  }
}

class _RollForm extends StatefulWidget {
  const _RollForm({
    required this.firstLabel,
    required this.secondLabel,
    required this.calculateTarget,
  });

  final String firstLabel;
  final String secondLabel;
  final String Function(int firstValue, int secondValue) calculateTarget;

  @override
  State<_RollForm> createState() => _RollFormState();
}

class _RollFormState extends State<_RollForm> {
  int? _firstValue;
  int? _secondValue;

  String get _target {
    final firstValue = _firstValue;
    final secondValue = _secondValue;
    if (firstValue == null || secondValue == null) {
      return '—';
    }
    return widget.calculateTarget(firstValue, secondValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _NumberInput(
                label: widget.firstLabel,
                onChanged: (value) => setState(() {
                  _firstValue = int.tryParse(value);
                }),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _NumberInput(
                label: widget.secondLabel,
                onChanged: (value) => setState(() {
                  _secondValue = int.tryParse(value);
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text('TIRADA OBJETIVO', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Text(_target, style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}

class _NumberInput extends StatelessWidget {
  const _NumberInput({required this.label, required this.onChanged});

  final String label;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label, hintText: '0'),
    );
  }
}

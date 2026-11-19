import 'package:flutter/material.dart';

import '../widgets/base_screen.dart';

class CombatScreen extends StatelessWidget {
  const CombatScreen({super.key});

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
          const Row(
            children: [
              Expanded(child: _ScoreColumn(label: 'Atacante')),
              SizedBox(width: 12),
              Expanded(child: _ScoreColumn(label: 'Defensor')),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(onPressed: () {}, child: const Text('Calcular')),
        ],
      ),
    );
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
  const _ScoreColumn({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    const bonuses = [
      'Estandarte',
      'Estandarte de Batalla',
      'Heridas sin Salvar',
      'Bono por Filas',
      'Formación Cerrada',
      'Infantería Concentrada',
      'Otros',
    ];
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
            '0',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 8),
        for (final bonus in bonuses) ...[
          OutlinedButton(onPressed: () {}, child: Text(bonus)),
          const SizedBox(height: 6),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/base_screen.dart';

class PhasesScreen extends StatelessWidget {
  const PhasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Fases',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'plan', label: Text('Modo plan')),
              ButtonSegment(value: 'game', label: Text('Modo juego')),
            ],
            selected: const {'plan'},
            onSelectionChanged: (_) {},
          ),
          const SizedBox(height: 20),
          Text('Turno 1', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const _PhaseFlow(),
          const SizedBox(height: 24),
          Text('Estrategia', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          for (final step in [
            'Inicio de turno',
            'Mando',
            'Conjuración',
            'Reagrupar unidades que huyen',
          ])
            CheckboxListTile(
              value: false,
              onChanged: (_) {},
              title: Text(step),
              contentPadding: EdgeInsets.zero,
            ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Nuevo recordatorio'),
          ),
        ],
      ),
    );
  }
}

class _PhaseFlow extends StatelessWidget {
  const _PhaseFlow();

  @override
  Widget build(BuildContext context) {
    const phases = ['Estrategia', 'Movimiento', 'Disparo', 'Combate'];
    return Row(
      children: [
        for (var index = 0; index < phases.length; index++)
          Expanded(
            child: Column(
              children: [
                CircleAvatar(radius: 16, child: Text('${index + 1}')),
                const SizedBox(height: 6),
                Text(
                  phases[index],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

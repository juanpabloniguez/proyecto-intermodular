import 'package:flutter/material.dart';

import '../widgets/base_screen.dart';

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'Puntos de Victoria',
      child: Column(
        children: [
          _PlayerCard(name: 'Jugador 1'),
          SizedBox(height: 16),
          _PlayerCard(name: 'Jugador 2'),
        ],
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '0',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final amount in [10, 25, 50, 100, 250])
                  OutlinedButton(onPressed: () {}, child: Text('+$amount')),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Personalizado'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

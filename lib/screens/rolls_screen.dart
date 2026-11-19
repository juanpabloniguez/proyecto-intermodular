import 'package:flutter/material.dart';

import '../widgets/base_screen.dart';

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
              height: 360,
              child: TabBarView(
                children: [
                  _RollView(
                    firstLabel: 'HA atacante',
                    secondLabel: 'HA defensor',
                  ),
                  _RollView(
                    firstLabel: 'F atacante',
                    secondLabel: 'R defensor',
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

class _RollView extends StatelessWidget {
  const _RollView({required this.firstLabel, required this.secondLabel});

  final String firstLabel;
  final String secondLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _NumberInput(label: firstLabel)),
            const SizedBox(width: 12),
            Expanded(child: _NumberInput(label: secondLabel)),
          ],
        ),
        const SizedBox(height: 32),
        Text('TIRADA OBJETIVO', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Text('4+', style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}

class _NumberInput extends StatelessWidget {
  const _NumberInput({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, hintText: '0'),
    );
  }
}

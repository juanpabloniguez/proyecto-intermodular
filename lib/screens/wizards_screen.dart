import 'package:flutter/material.dart';

import '../widgets/base_screen.dart';

class WizardsScreen extends StatelessWidget {
  const WizardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Magos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'No hay magos guardados',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Crea un mago para gestionar sus conocimientos y conjuros.',
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Crear mago'),
          ),
        ],
      ),
    );
  }
}

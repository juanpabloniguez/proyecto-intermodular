import 'package:flutter/material.dart';

import '../theme/app_appearance.dart';
import 'combat_screen.dart';
import 'phases_screen.dart';
import 'preferences_screen.dart';
import 'rolls_screen.dart';
import 'victory_screen.dart';
import 'wizards_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    super.key,
    required this.appearance,
    required this.onAppearanceChanged,
  });

  final AppAppearance appearance;
  final ValueChanged<AppAppearance> onAppearanceChanged;

  @override
  Widget build(BuildContext context) {
    final entries = [
      (
        'Resultados de Combate',
        'Bonos, resultado y Liderazgo',
        Icons.shield_outlined,
        const CombatScreen(),
      ),
      (
        'Puntos de Victoria',
        'Lleva la cuenta de ambos jugadores',
        Icons.emoji_events_outlined,
        const VictoryScreen(),
      ),
      (
        'Impactar/Herir',
        'Consulta la tirada objetivo',
        Icons.casino_outlined,
        const RollsScreen(),
      ),
      (
        'Magos',
        'Gestiona tus magos y conjuros',
        Icons.auto_awesome_outlined,
        const WizardsScreen(),
      ),
      (
        'Fases',
        'Planifica y recorre cada turno',
        Icons.view_timeline_outlined,
        const PhasesScreen(),
      ),
      (
        'Preferencias',
        'Idioma y apariencia',
        Icons.settings_outlined,
        PreferencesScreen(
          appearance: appearance,
          onAppearanceChanged: onAppearanceChanged,
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
          children: [
            Text(
              'THE OLD WORLD',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 2,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Cuaderno de batalla',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Tu turno, bajo control.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Herramientas de consulta y seguimiento para tus partidas.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            for (final entry in entries) ...[
              _MenuCard(
                title: entry.$1,
                description: entry.$2,
                icon: entry.$3,
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute<void>(builder: (_) => entry.$4)),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colors.outline),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: colors.primary),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(description),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

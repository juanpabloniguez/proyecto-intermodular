import 'package:flutter/material.dart';

void main() {
  runApp(const OldWorldCompanionApp());
}

enum AppAppearance {
  reikland(
    'Reikland',
    'Diurno - Rojo',
    Color(0xFFFFFFFF),
    Color(0xFFF4F5F7),
    Color(0xFF20242A),
    Color(0xFF59616C),
    Color(0xFFD7DBE0),
    Color(0xFF7B293B),
    Color(0xFFFFFFFF),
  ),
  middenland(
    'Middenland',
    'Diurno - Azul',
    Color(0xFFFFFFFF),
    Color(0xFFF4F5F7),
    Color(0xFF20242A),
    Color(0xFF59616C),
    Color(0xFFD7DBE0),
    Color(0xFF23486C),
    Color(0xFFFFFFFF),
  ),
  stirland(
    'Stirland',
    'Diurno - Verde',
    Color(0xFFFFFFFF),
    Color(0xFFF4F5F7),
    Color(0xFF20242A),
    Color(0xFF59616C),
    Color(0xFFD7DBE0),
    Color(0xFF224E3C),
    Color(0xFFFFFFFF),
  ),
  nuln(
    'Nuln',
    'Noche - Azul',
    Color(0xFF15181D),
    Color(0xFF222730),
    Color(0xFFF1EEE7),
    Color(0xFFB4BAC4),
    Color(0xFF414954),
    Color(0xFF91ADCB),
    Color(0xFF15181D),
  ),
  talabecland(
    'Talabecland',
    'Clásico',
    Color(0xFFF1E5CC),
    Color(0xFFFAF3E3),
    Color(0xFF33291F),
    Color(0xFF6D5A43),
    Color(0xFFCAB892),
    Color(0xFF803629),
    Color(0xFFFFFFFF),
  );

  const AppAppearance(
    this.label,
    this.description,
    this.background,
    this.surface,
    this.primaryText,
    this.secondaryText,
    this.border,
    this.accent,
    this.onAccent,
  );

  final String label;
  final String description;
  final Color background;
  final Color surface;
  final Color primaryText;
  final Color secondaryText;
  final Color border;
  final Color accent;
  final Color onAccent;
}

class OldWorldCompanionApp extends StatefulWidget {
  const OldWorldCompanionApp({super.key});

  @override
  State<OldWorldCompanionApp> createState() => _OldWorldCompanionAppState();
}

class _OldWorldCompanionAppState extends State<OldWorldCompanionApp> {
  AppAppearance appearance = AppAppearance.reikland;

  ThemeData get theme {
    final colors = appearance;
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme(
        brightness: colors == AppAppearance.nuln
            ? Brightness.dark
            : Brightness.light,
        primary: colors.accent,
        onPrimary: colors.onAccent,
        secondary: colors.accent,
        onSecondary: colors.onAccent,
        error: colors == AppAppearance.nuln
            ? const Color(0xFFF0A0A8)
            : const Color(0xFFA32732),
        onError: colors.onAccent,
        surface: colors.surface,
        onSurface: colors.primaryText,
        outline: colors.border,
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: colors.primaryText,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: colors.primaryText,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: colors.primaryText,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: colors.primaryText),
        bodyMedium: TextStyle(color: colors.secondaryText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.primaryText,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Old World Companion',
      theme: theme,
      home: MainMenuScreen(
        appearance: appearance,
        onAppearanceChanged: (value) => setState(() => appearance = value),
      ),
    );
  }
}

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

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Menú',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: child,
        ),
      ),
    );
  }
}

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
          Row(
            children: const [
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

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Puntos de Victoria',
      child: Column(
        children: const [
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

class RollsScreen extends StatelessWidget {
  const RollsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Impactar / Herir',
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: const [
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

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({
    super.key,
    required this.appearance,
    required this.onAppearanceChanged,
  });

  final AppAppearance appearance;
  final ValueChanged<AppAppearance> onAppearanceChanged;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Preferencias',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Idioma', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Español'),
            trailing: Text('Actual'),
          ),
          const SizedBox(height: 20),
          Text('Apariencia', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          RadioGroup<AppAppearance>(
            groupValue: appearance,
            onChanged: (value) {
              if (value != null) onAppearanceChanged(value);
            },
            child: Column(
              children: [
                for (final option in AppAppearance.values)
                  RadioListTile<AppAppearance>(
                    value: option,
                    title: Text(option.label),
                    subtitle: Text(option.description),
                    contentPadding: EdgeInsets.zero,
                  ),
              ],
            ),
          ),
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

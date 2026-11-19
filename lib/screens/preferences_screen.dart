import 'package:flutter/material.dart';

import '../theme/app_appearance.dart';
import '../widgets/base_screen.dart';

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

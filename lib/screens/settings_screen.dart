import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../utils/localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('settings')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section Thème
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('theme'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildThemeOption(
                    context,
                    themeProvider,
                    languageProvider,
                    ThemeMode.light,
                    Icons.light_mode,
                  ),
                  _buildThemeOption(
                    context,
                    themeProvider,
                    languageProvider,
                    ThemeMode.dark,
                    Icons.dark_mode,
                  ),
                  //_buildThemeOption(
                    //context,
                   // themeProvider,
                   // languageProvider,
                   // ThemeMode.system,
                   // Icons.settings,
                  //),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Section Langue
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('language'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildLanguageOption(
                    context,
                    languageProvider,
                    const Locale('en'),
                    '🇺🇸',
                  ),
                  _buildLanguageOption(
                    context,
                    languageProvider,
                    const Locale('fr'),
                    '🇫🇷',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Section Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Version'),
                    subtitle: const Text('1.0.0'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.code),
                    title: const Text('Développeur'),
                    subtitle: const Text('E-Commerce App'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.api),
                    title: const Text('API'),
                    subtitle: const Text('Fake Store API'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
      BuildContext context,
      ThemeProvider themeProvider,
      LanguageProvider languageProvider,
      ThemeMode mode,
      IconData icon,
      ) {
    final isSelected = themeProvider.themeMode == mode;

    return ListTile(
      leading: Icon(icon),
      title: Text(languageProvider.getThemeName(context, mode)),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () => themeProvider.setTheme(mode),
      tileColor: isSelected
          ? Theme.of(context).primaryColor.withOpacity(0.1)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context,
      LanguageProvider languageProvider,
      Locale locale,
      String flag,
      ) {
    final isSelected = languageProvider.locale.languageCode == locale.languageCode;

    return ListTile(
      leading: Text(
        flag,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        locale.languageCode == 'en'
            ? context.tr('english')
            : context.tr('french'),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () => languageProvider.setLocale(locale),
      tileColor: isSelected
          ? Theme.of(context).primaryColor.withOpacity(0.1)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
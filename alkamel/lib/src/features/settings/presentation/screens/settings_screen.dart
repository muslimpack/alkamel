import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/features/settings/presentation/components/font_settings_widgets.dart';
import 'package:alkamel/src/features/themes/presentation/controller/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).settings),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              SwitchListTile(
                value: state.brightness == Brightness.dark,
                title: Text(S.of(context).prefThemeDarkMode),
                onChanged: (value) {
                  if (state.brightness == Brightness.dark) {
                    context
                        .read<ThemeCubit>()
                        .changeBrightness(Brightness.light);
                  } else {
                    context
                        .read<ThemeCubit>()
                        .changeBrightness(Brightness.dark);
                  }
                },
              ),
              ListTile(
                title: Text(S.of(context).prefAppLanguage),
                subtitle: Wrap(
                  children: List.generate(
                    S.delegate.supportedLocales.length,
                    (index) {
                      final locale = S.delegate.supportedLocales[index];

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ToggleButton(
                          label: Text(locale.languageCode),
                          selected:
                              state.locale?.languageCode == locale.languageCode,
                          showCheckmark: false,
                          onSelected: (value) {
                            context
                                .read<ThemeCubit>()
                                .changeAppLocale(locale.languageCode);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Divider(),
              const FontSettingsToolbox(),
            ],
          ),
        );
      },
    );
  }
}

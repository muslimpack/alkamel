import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/core/di/dependency_injection.dart';
import 'package:alkamel/src/core/extensions/extension_platform.dart';
import 'package:alkamel/src/features/home/presentation/screens/home_screen.dart';
import 'package:alkamel/src/features/themes/presentation/controller/cubit/theme_cubit.dart';
import 'package:alkamel/src/features/ui/presentation/components/desktop_window_wrapper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AlkamelApp extends StatelessWidget {
  const AlkamelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            onGenerateTitle: (context) => S.of(context).appTitle,
            theme: state.theme,
            locale: state.locale,
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            navigatorObservers: [
              BotToastNavigatorObserver(),
            ],
            builder: (context, child) {
              if (PlatformExtension.isDesktop) {
                final botToastBuilder = BotToastInit();
                return DesktopWindowWrapper(
                  child: botToastBuilder(context, child),
                );
              }
              return child ?? const SizedBox();
            },
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Al-Kamel fe al-Sunan`
  String get appTitle {
    return Intl.message(
      'Al-Kamel fe al-Sunan',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copiedToClipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Decrease font size`
  String get fontDecreaseSize {
    return Intl.message(
      'Decrease font size',
      name: 'fontDecreaseSize',
      desc: '',
      args: [],
    );
  }

  /// `Increase font size`
  String get fontIncreaseSize {
    return Intl.message(
      'Increase font size',
      name: 'fontIncreaseSize',
      desc: '',
      args: [],
    );
  }

  /// `Reset font size`
  String get fontResetSize {
    return Intl.message(
      'Reset font size',
      name: 'fontResetSize',
      desc: '',
      args: [],
    );
  }

  /// `Font settings`
  String get fontSettings {
    return Intl.message(
      'Font settings',
      name: 'fontSettings',
      desc: '',
      args: [],
    );
  }

  /// `Misspelled`
  String get misspelled {
    return Intl.message(
      'Misspelled',
      name: 'misspelled',
      desc: '',
      args: [],
    );
  }

  /// `App language`
  String get prefAppLanguage {
    return Intl.message(
      'App language',
      name: 'prefAppLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get prefThemeDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'prefThemeDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Report misspelled`
  String get reportMisspelled {
    return Intl.message(
      'Report misspelled',
      name: 'reportMisspelled',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search filters`
  String get searchFilters {
    return Intl.message(
      'Search filters',
      name: 'searchFilters',
      desc: '',
      args: [],
    );
  }

  /// `Search result count`
  String get searchResultCount {
    return Intl.message(
      'Search result count',
      name: 'searchResultCount',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Share as image`
  String get shareAsImage {
    return Intl.message(
      'Share as image',
      name: 'shareAsImage',
      desc: '',
      args: [],
    );
  }

  /// `Show diacritics`
  String get showDiacritics {
    return Intl.message(
      'Show diacritics',
      name: 'showDiacritics',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

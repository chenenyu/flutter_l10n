# flutter_l10n

![Pub Version (including pre-releases)](https://img.shields.io/pub/v/flutter_l10n)

A dart library that generates Flutter localization code from ARB file.

This library is an extension of official Flutter localizations. You can refer to [👉here👈](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization#configuring-the-l10nyaml-file) to config the `flutter_l10n.yaml`.

[Online demo](https://chenenyu.github.io/flutter_l10n/)

## Features

- Compatible with official APIs.
- Support multiple packages/modules.
- Support using without `context`.

## Getting Started

### Install / Update

`dart pub global activate flutter_l10n`

### Usage

1. Generate `S.dart` file from `*.arb` files in your project directory: `flutter_l10n generate`.

2. Register in `MaterialApp`/`WidgetsApp`:
```dart
MaterialApp(
  localizationsDelegates: [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
);
```

3. Reference strings by `S.of(context).helloWorld` or `S.current.helloWorld`.



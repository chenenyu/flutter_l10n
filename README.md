# flutter_l10n

![Pub](https://img.shields.io/pub/v/flutter_l10n?style=for-the-badge)

Flutter localizations.

## Getting Started

### Install

```yaml
dev_dependencies:
  ...
  flutter_l10n: '^0.1.3'
```

### Usage

1. Generate `S.dart` file from `*.arb` files.  
`flutter pub run flutter_l10n:build`.

2. Register in `MaterialApp`/`WidgetsApp`:
```dart
MaterialApp(
  localizationsDelegates: [
    S.delegate,
  ],
);
```

3. Reference strings by `S.of(context).***`.

4. You can use string interpolation as you wrote dart code. For example:
`S.of(context).title(value)`
`"title": "App Number $value"`
or
`"title": "App ${value}N"`




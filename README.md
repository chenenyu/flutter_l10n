# flutter_l10n

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




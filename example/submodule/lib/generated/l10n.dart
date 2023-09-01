import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart' deferred as l10n_en;
import 'l10n_zh.dart' deferred as l10n_zh;

/// Callers can lookup localized strings with an instance of SubS
/// returned by `SubS.of(context)`.
///
/// Applications need to include `SubS.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: const [
///     SubS.delegate,
///     GlobalMaterialLocalizations.delegate,
///     GlobalCupertinoLocalizations.delegate,
///     GlobalWidgetsLocalizations.delegate,
///   ],
///   supportedLocales: SubS.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the SubS.supportedLocales
/// property.
abstract class SubS {
  SubS(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SubS? _current;

  static SubS get current {
    assert(_current != null,
        'Try to initialize the SubS delegate before accessing SubS.current.');
    return _current!;
  }

  static SubS? of(BuildContext context) {
    return Localizations.of<SubS>(context, SubS);
  }

  static const LocalizationsDelegate<SubS> delegate = _SubSDelegate();

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World! - from submodule'**
  String get helloWorld;
}

class _SubSDelegate extends LocalizationsDelegate<SubS> {
  const _SubSDelegate();

  @override
  Future<SubS> load(Locale locale) {
    return lookupSubS(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SubSDelegate old) => false;
}

Future<SubS> lookupSubS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return l10n_en.loadLibrary().then((dynamic _) {
        SubS._current = l10n_en.SubSEn();
        return SubS.current;
      });
    case 'zh':
      return l10n_zh.loadLibrary().then((dynamic _) {
        SubS._current = l10n_zh.SubSZh();
        return SubS.current;
      });
  }

  throw FlutterError(
      'SubS.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

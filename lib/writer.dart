import 'dart:io';

import 'package:flutter_l10n/ArbFile.dart';
import 'package:path/path.dart';

import 'log.dart';

const String _comment = '// Generated by flutter_l10n. Do not edit it.';

// See http://en.wikipedia.org/wiki/Right-to-left
const List<String> _rtlLanguages = <String>[
  'ar', // Arabic   阿拉伯语
  'fa', // Farsi    波斯语
  'he', // Hebrew   希伯来语
  'ps', // Pashto   普什图语
  'ur', // Urdu     乌尔都语
];

StringBuffer _sb = StringBuffer();

void writeClasses(Directory outputDir, List<ArbFile> all) {
  final arbFiles = <ArbFile>[];
  ArbFile defaultArbFile;
  for (var arbFile in all) {
    if (defaultArbFile == null && arbFile.isDefault) {
      defaultArbFile = arbFile;
    } else {
      arbFiles.add(arbFile);
    }
  }
  if (defaultArbFile == null) {
    defaultArbFile = all.first;
    if (Platform.localeName.startsWith('zh')) {
      log.warning("自动选择[${basename(defaultArbFile.file.path)}]作为默认locale。"
          "你也可以在某个arb文件中通过{\"@@locale\": \"default\"}来指定。");
    } else {
      log.warning("Auto choose [${basename(defaultArbFile.file.path)}] as default locale. "
          "You can also specify it by insert a pair of key/value "
          "like {\"@@locale\": \"default\"} in some arb file.");
    }
  } else {
    all.remove(defaultArbFile);
    log.info("Find [locale: default, arb: ${defaultArbFile.file.path}]");
  }

  _sb.clear();

  // ----- begin: S -----
  final delegateName = 'DelegateS';

  // write import
  _writeln("library s;");
  _writeln("");
  _writeln("import 'package:flutter/foundation.dart';");
  _writeln("import 'package:flutter/widgets.dart';");
  _writeln('');
  _writeln('// ignore_for_file: non_constant_identifier_names');
  _writeln('// ignore_for_file: camel_case_types');
  _writeln('// ignore_for_file: prefer_single_quotes');
  _writeln("");
  arbFiles.forEach((f) {
    log.info("Find [locale: ${f.locale.padRight(7)}, arb: ${f.file.path}]");
    _writeln("part '${f.locale}.dart';");
  });
  _writeln("");

  // write S
  _writeln(_comment);
  _writeln("class S implements WidgetsLocalizations {");
  _writeln("const S();", depth: 1);
  _writeln("");
  _writeln("@override", depth: 1);
  _writeln("TextDirection get textDirection => TextDirection.ltr;", depth: 1);
  _writeln("");
  _writeln("static S of(BuildContext context) => Localizations.of<S>(context, S);", depth: 1);
  _writeln("");
  _writeln("static const $delegateName delegate = $delegateName();", depth: 1);

  _writeStrings(defaultArbFile.strings, false);
  _writeln("}");
  _writeln("");

  // write _Delegate

  _writeln("class $delegateName extends LocalizationsDelegate<S> {");
  _writeln("const $delegateName();", depth: 1);
  // write supportedLocales for _Delegate
  _writeln("");
  _writeln("List<Locale> get supportedLocales {", depth: 1);
  _writeln("return const <Locale>[", depth: 2);
  for (var file in arbFiles) {
    _writeln("Locale('${file.locale}'),", depth: 3);
  }
  _writeln("];", depth: 2);
  _writeln("}", depth: 1);
  // write load method for _Delegate
  _writeln("");
  _writeln("Future<S> load(Locale locale) {", depth: 1, override: true);
  if (arbFiles.isNotEmpty) {
    _writeln("String tag = locale.countryCode == null || locale.countryCode.isEmpty", depth: 2);
    _writeln("? locale.languageCode", depth: 4);
    _writeln(": locale.toString();", depth: 4);
    _writeln("switch (tag) {", depth: 2);
    arbFiles.forEach((f) {
      _writeln("case '${f.locale}':", depth: 3);
      _writeln("return SynchronousFuture<S>(const \$${f.locale}());", depth: 4);
    });
    _writeln("}", depth: 2);
  }
  _writeln("return SynchronousFuture<S>(const S());", depth: 2);
  _writeln("}", depth: 1);
  // write isSupported method for _Delegate
  _writeln("");
  _writeln("bool isSupported(Locale locale) {", depth: 1, override: true);
  _writeln('if (locale != null) {', depth: 2);
  _writeln('for (Locale supportedLocale in supportedLocales) {', depth: 3);
  _writeln('if (supportedLocale.languageCode == locale.languageCode', depth: 4);
  _writeln('&& supportedLocale.countryCode == locale.countryCode) return true;', depth: 6);
  _writeln('}', depth: 3);
  _writeln('}', depth: 2);
  _writeln('return false;', depth: 2);
  _writeln("}", depth: 1);
  _writeln("");
  _writeln("bool shouldReload($delegateName old) => false;", depth: 1, override: true);
  _writeln("}");

  File s = File(join(outputDir.path, 's.dart'));
  s.writeAsStringSync(_sb.toString());
  // ----- finish: S -----

  // ----- begin: locale class -----
  arbFiles.forEach((f) {
    _sb.clear();
    _writeln("part of s;");
    _writeln("");
    _writeln(_comment);
    _writeln("class \$${f.locale} extends S {");
    _writeln("const \$${f.locale}();", depth: 1);
    _writeln("");
    if (_rtlLanguages.contains(k)) {
      _writeln("TextDirection get textDirection => TextDirection.rtl;",
          depth: 1, override: true);
    } else {
      _writeln("TextDirection get textDirection => TextDirection.ltr;",
          depth: 1, override: true);
    }
    _writeStrings(f.strings, true);
    _writeln("}");

    File locale =
        File(join(outputDir.path, basenameWithoutExtension(v.path) + '.dart'));
    locale.writeAsStringSync(_sb.toString());
  });
  // ----- finish: locale class -----
}

void _writeStrings(Map<String, dynamic> map, bool override) {
  map.forEach((key, value) {
    if (!key.startsWith('@')) {
      if (value == null) {
        _writeln("");
        _writeln("String get $key => $value;", depth: 1, override: override);
      } else if (value is String) {
        _writeString(key, value, override);
      }
    }
  });
}

// with dollar and graph (?<!\$)(?<d>\$\w+)|(?<!\$)(?<g>\$\{\w+\})
final _paramRegExp =
    RegExp(r'(?:(?<!\$\$)(?<=\$)(?<d>\w+))|(?:(?<!\$\$\{)(?<=\$\{)(?<g>\w+)(?=\}))');

void _writeString(String key, String value, bool override) {
  // search parameters
  final paramMatchers = _paramRegExp.allMatches(value);
  final string = "'''${value.replaceAll('\$\$', '\\\$')}'''";

  if (paramMatchers.isNotEmpty) {
    final args = <String>[];
    for (var match in paramMatchers) {
      final dollarGroup = match.namedGroup('d');
      if (dollarGroup != null) args.add(dollarGroup);
      final graphGroup = match.namedGroup('g');
      if (graphGroup != null) args.add(graphGroup);
    }
    final argsString = args.map((arg) => 'String $arg').join(", ");
    // write method
    _writeln("");
    _writeln("String $key($argsString) {", depth: 1, override: override);
    _writeln("return $string;", depth: 2);
    _writeln("}", depth: 1);
  } else {
    // normal string
    _writeln("");
    _writeln("String get $key => $string;", depth: 1, override: override);
  }
}

void _writeln(String content, {int depth = 0, bool override = false}) {
  if (override == true) {
    _write("@override", depth: depth);
    _sb.writeln();
  }
  _write(content, depth: depth);
  _sb.writeln();
}

void _write(String content, {int depth = 0}) {
  if (depth > 0) {
    for (int i = 0; i < depth; i++) {
      _sb.write("  "); // 1 depth = 2 tabs
    }
  }
  _sb.write(content);
}

import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get helloWorld => '你好，世界!';

  @override
  String hello(Object myName, Object yourName) {
    return '你好$yourName，我是$myName';
  }

  @override
  String helloWithAttrs(String myName, String yourName) {
    return '你好$yourName，我是$myName';
  }

  @override
  String nPandas(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString只熊猫',
      one: '一只熊猫',
      zero: '没有熊猫',
    );
    return '$_temp0';
  }

  @override
  String pronoun(String gender) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'male': '他',
        'female': '她',
        'other': '他们',
      },
    );
    return '$_temp0';
  }

  @override
  String numberOfDataPoints(int value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String valueString = valueNumberFormat.format(value);

    return '数值: $valueString';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class SZhTw extends SZh {
  SZhTw() : super('zh_TW');

  @override
  String get helloWorld => '你好，世界!';

  @override
  String hello(Object myName, Object yourName) {
    return '你好$yourName，我是$myName';
  }

  @override
  String helloWithAttrs(String myName, String yourName) {
    return '你好$yourName，我是$myName';
  }

  @override
  String nPandas(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString隻熊貓',
      one: '一隻熊貓',
      zero: '沒有熊貓',
    );
    return '$_temp0';
  }

  @override
  String pronoun(String gender) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'male': '他',
        'female': '她',
        'other': '他們',
      },
    );
    return '$_temp0';
  }

  @override
  String numberOfDataPoints(int value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String valueString = valueNumberFormat.format(value);

    return '數值: $valueString';
  }
}

import 'l10n.dart';

/// The translations for Chinese (`zh`).
class SubSZh extends SubS {
  SubSZh([String locale = 'zh']) : super(locale);

  @override
  String get helloWorld => '你好，世界！- 来自submodule';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class SubSZhTw extends SubSZh {
  SubSZhTw() : super('zh_TW');

  @override
  String get helloWorld => '你好，世界！- 來自submodule';
}

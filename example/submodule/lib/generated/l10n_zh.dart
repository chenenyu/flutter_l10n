import 'l10n.dart';

/// The translations for Chinese (`zh`).
class SubSZh extends SubS {
  SubSZh([String locale = 'zh']) : super(locale);

  @override
  String get helloWorld => '你好，世界！- 来自submodule';
}

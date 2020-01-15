import 'dart:io';

import 'package:path/path.dart' as path;

class ArbFile {
  final File file;
  final Map<String, dynamic> strings;
  final String filename;

  ArbFile(this.file, this.strings) : filename = path.basenameWithoutExtension(file.path);

  bool get isDefault => strings['@@locale'] == 'default';

  String get locale => filename;
}

import 'dart:io';

import 'package:file/file.dart';
import 'package:yaml/yaml.dart';

/// Gets the pubspec file.
File? getPubspecYamlFile(FileSystem fs) {
  File file = fs.currentDirectory.childFile('pubspec.yaml');
  return file.existsSync() ? file : null;
}

/// Gets the pubspec file.
File? getL10nYamlFile(FileSystem fs) {
  File file = fs.currentDirectory.childFile('flutter_l10n.yaml');
  return file.existsSync() ? file : null;
}

/// Read name from pubspec.yaml.
String readNameFromPubspecYaml(File file) {
  YamlMap yaml = loadYaml(file.readAsStringSync());
  return yaml['name'];
}

void info(String message) => stdout.writeln('INFO: $message');

void warning(String message) => stdout.writeln('WARNING: $message');

void error(String message) => stderr.writeln('ERROR: $message');

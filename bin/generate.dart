import 'package:dart_style/dart_style.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_l10n/src/gen_l10n.dart';
import 'package:flutter_l10n/src/localizations_utils.dart';
import 'package:flutter_l10n/src/utils.dart';
import 'package:path/path.dart';

Future<void> main(List<String> args) async {
  const FileSystem fs = LocalFileSystem();

  File? pubspecFile = getPubspecYamlFile(fs);
  if (getPubspecYamlFile(fs) == null) {
    error('No pubspec.yaml file found.');
    return;
  }

  String name = readNameFromPubspecYaml(pubspecFile!);
  info('$name: Generating localizations...');

  late LocalizationOptions options;

  String defaultArbDir = join('lib', 'l10n');
  File? l10nFile = getL10nYamlFile(fs);
  if (l10nFile == null) {
    options = LocalizationOptions(arbDir: defaultArbDir);
  } else {
    options = parseLocalizationsOptionsFromYAML(
        file: l10nFile, defaultArbDir: defaultArbDir);
  }

  LocalizationsGenerator generator = generateLocalizations(
    projectDir: fs.currentDirectory,
    options: options,
    fileSystem: fs,
  );

  if (options.format) {
    var formatter = DartFormatter();
    generator.outputFileList.forEach((path) {
      var file = fs.file(path);
      file.writeAsString(formatter.format(file.readAsStringSync()));
    });
  }

  info('$name: Done.');
}

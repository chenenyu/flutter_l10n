import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_l10n/log.dart';
import 'package:flutter_l10n/reader.dart';
import 'package:flutter_l10n/writer.dart';

main(List<String> args) {
  initLog();
  ArgParser parser = new ArgParser();
  parser.addFlag('help', abbr: 'h', negatable: false, callback: (bool value) {
    if (value) {
      print(parser.usage);
      exit(0);
    }
  });
  parser.addOption('input',
      abbr: 'i', defaultsTo: 'lib/', help: 'input dir for finding arb files.');
  parser.addOption('output',
      abbr: 'o',
      defaultsTo: 'lib/l10n/',
      help:
          'output dir for generated dart files, should be a sub path of lib/.');
  ArgResults results = parser.parse(args);
  String inputPath = results['input'];
  String outputPath = results['output'];
  Directory inputDir = Directory(inputPath);
  Directory outputDir = Directory(outputPath);
  if (!inputDir.existsSync()) {
    throw FileSystemException('Directory not exists', inputDir.path);
  }

  List<FileSystemEntity> arbFiles =
      inputDir.listSync(recursive: true).where((f) {
    return FileSystemEntity.isFileSync(f.path) && f.path.endsWith('.arb');
  }).toList();
  if (arbFiles.isEmpty) {
    log.info('No arb files found in ${inputDir.path}.');
    exit(0);
  }

  Map<File, Map<String, dynamic>> all = {};
  arbFiles.forEach((arb) {
    if (arb is File) {
      Map<String, dynamic> arbMap = parseArb(arb);
      if (arbMap != null) {
        all[arb] = arbMap;
      }
    }
  });

  if (all.isEmpty) {
    exit(0);
  }

  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }
  writeClasses(outputDir, all);
}

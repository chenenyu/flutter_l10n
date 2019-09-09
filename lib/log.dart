import 'package:logging/logging.dart';

Logger log = Logger('flutter_l10n');

void initLog() {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.message}');
  });
}

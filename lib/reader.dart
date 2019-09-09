import 'dart:convert';
import 'dart:io';

import 'log.dart';

Map<String, dynamic> parseArb(File arb) {
  Map<String, dynamic> json;
  try {
    json = jsonDecode(arb.readAsStringSync());
  } catch (e) {
    log.severe('${arb.path} is not a valid json file.', e);
    exit(1);
  }

  if (json == null || json.isEmpty) {
    log.info('Skip ${arb.path}.');
    return null;
  }
  Map<String, dynamic> map = {};
  json.forEach((String key, dynamic value) {
    if (isAcceptable(key, value)) {
      map[key] = value;
    } else {
      // invalid
      log.warning('Invalid key: $key.');
    }
  });
  if (map.isEmpty) {
    log.warning('Skip ${arb.path}.');
    return null;
  }
  return map;
}

/// Valid KV
bool isAcceptable(String key, dynamic value) {
  return isStringKey(key, value) || isAtKey(key, value) || is2AtKey(key, value);
}

final RegExp _keyPattern = RegExp(r'[a-zA-Z]');

bool isStringKey(String key, dynamic value) {
  if (key.startsWith(_keyPattern)) {
    if (value == null || value is String) {
      return true;
    } else {
      log.warning('Ignore key: $key.');
    }
  }
  return false;
}

bool isAtKey(String key, dynamic value) {
  if (key.startsWith('@') && !key.startsWith('@@')) {
    if (value is Map) {
      return true;
    } else {
      log.warning('Ignore key: $key.');
    }
  }
  return false;
}

bool is2AtKey(String key, dynamic value) {
  if (key.startsWith('@@')) {
    if (value is String) {
      return true;
    } else {
      log.warning('Ignore key: $key.');
    }
  }
  return false;
}

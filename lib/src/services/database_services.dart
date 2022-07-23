import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/utilities/hive_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box? box;

class HiveStorage {
  static Future<Box> openBox() async {
    return box = await Hive.openBox(HiveKeys.appBox);
  }

  FutureOr<dynamic> put(dynamic key, dynamic value) async {
    return await box!.put(key, value);
  }

  dynamic get(String key) {
    return box!.get(key);
  }

  dynamic getAt(int key) {
    return box!.getAt(key);
  }

  Future<int> add(value) async {
    return await box!.add(value);
  }

  Future<int> delete() async {
    return await box!.clear();
  }
}

final hiveProvider = Provider((ref) => HiveStorage());

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/utilities/hive_keys.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';
import 'package:ninja_connect/src/repositories/users_repository.dart';
import 'package:ninja_connect/src/services/database_services.dart';

final appUserProvider = StreamProvider<AppUser>((ref) {
  final userId = ref.read(hiveProvider).get(HiveKeys.userId);
  return ref.watch(userRepository).getUser(userId);
});

final appUserFutureProvider = FutureProvider<AppUser>((ref) {
  final userId = ref.read(hiveProvider).get(HiveKeys.userId);
  return ref.watch(userRepository).getFutureUser(userId);
});

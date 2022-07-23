import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/firebase_options.dart';
import 'package:ninja_connect/src/core/constants/strings.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/core/themes.dart';
import 'package:ninja_connect/src/features/start_up/views/startup_view.dart';
import 'package:ninja_connect/src/services/database_services.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/services/snackbar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await HiveStorage.openBox();
  runApp(const ProviderScope(child: NaijaConnect()));
}

class NaijaConnect extends ConsumerWidget {
  const NaijaConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      home: const SplashView(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: ref.read(navigationService).navigatorKey,
      scaffoldMessengerKey: ref.read(snackbarService).scaffoldMessengerKey,
    );
  }
}

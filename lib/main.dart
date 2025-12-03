import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/core/router/app_router.dart';
import 'package:final_l3/core/themes/app_theme.dart';
import 'package:final_l3/core/themes/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('usersBox');
  await Hive.openBox('favouritesBox');
  await Hive.openBox('cacheBox');
  await Hive.openBox('settingsBox');
  await Di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.isDarkMode,
      builder: (context, mode, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.goRouter,
          title: 'L3',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}

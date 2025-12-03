import 'package:final_l3/core/di/di.dart';
import 'package:final_l3/core/router/app_router.dart';
import 'package:flutter/material.dart';

void main() async {
  await Di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Final L3',
    );
  }
}

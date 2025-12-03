import 'package:final_l3/core/constants/routes_constants.dart';
import 'package:final_l3/presentation/features/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutesConstants.loginRoute,
    routes: [
      GoRoute(
        path: RoutesConstants.loginRoute,
        builder: (BuildContext context, GoRouterState state) => LoginScreen(),
      ),
    ],
  );
}

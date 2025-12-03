import 'package:final_l3/core/constants/routes_constants.dart';
import 'package:final_l3/core/router/bottom_shell.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';
import 'package:final_l3/presentation/features/coin_details/screens/coin_details_screen.dart';
import 'package:final_l3/presentation/features/dashboard/screens/dashboard_screen.dart';
import 'package:final_l3/presentation/features/favourites/screens/favourite_screen.dart';
import 'package:final_l3/presentation/features/login/screen/login_screen.dart';
import 'package:final_l3/presentation/features/profile/screens/profile_screen.dart';
import 'package:final_l3/presentation/features/register/screen/register_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutesConstants.loginRoute,
    routes: [
      GoRoute(
        path: RoutesConstants.loginRoute,
        builder: (context, _) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutesConstants.registerRoute,
        builder: (context, _) => const RegisterScreen(),
      ),

      ShellRoute(
        builder: (_, _, child) => BottomShell(child: child),
        routes: [
          GoRoute(
            path: RoutesConstants.dashboardRoute,
            builder: (context, state) => const DashboardScreen(),
          ),

          GoRoute(
            path: RoutesConstants.favouritesRoute,
            builder: (context, state) => FavouriteScreen(),
          ),

          GoRoute(
            path: RoutesConstants.profileRoute,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      GoRoute(
        path: RoutesConstants.details,
        builder: (context, state) {
          final CryptoEntity coin = state.extra! as CryptoEntity;
          return CoinDetailsScreen(cryptoEntity: coin);
        },
      ),
    ],
  );
}

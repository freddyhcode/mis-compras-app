import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/router/app_routes.dart';
import 'package:mis_compras_app/core/router/app_shell.dart';
import 'package:mis_compras_app/core/router/providers/router_provider.dart';
import 'package:mis_compras_app/features/home/presentation/screens/home_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/history_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/product_form_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_detail_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_form_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchases_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/statistics_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/about_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/appearance_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/creator_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/legal_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:mis_compras_app/features/tutorial/presentation/screens/tutorial_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final routerState = ref.watch(routerProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      if (routerState.isLoading) return null;

      final isTutorial = state.matchedLocation == AppRoutes.tutorial;

      if (!routerState.hasSeenTutorial && !isTutorial) {
        return AppRoutes.tutorial;
      }
      if (routerState.hasSeenTutorial && isTutorial) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: HomeScreen.name,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                name: HistoryScreen.name,
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.statistics,
                name: StatisticsScreen.name,
                builder: (context, state) => const StatisticsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                name: SettingsScreen.name,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.tutorial,
        name: TutorialScreen.name,
        builder: (context, state) => const TutorialScreen(),
      ),
      GoRoute(
        path: AppRoutes.purchases,
        name: PurchasesScreen.name,
        builder: (context, state) => const PurchasesScreen(),
      ),
      GoRoute(
        path: AppRoutes.purchaseNew,
        name: PurchaseFormScreen.newName,
        builder: (context, state) => const PurchaseFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.purchaseDetail,
        name: PurchaseDetailScreen.name,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          if (id == null) return const PurchasesScreen();
          return PurchaseDetailScreen(purchaseId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.purchaseEdit,
        name: PurchaseFormScreen.editName,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          if (id == null) return const PurchasesScreen();
          return PurchaseFormScreen(purchaseId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.purchaseProduct,
        name: ProductFormScreen.name,
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          if (id == null) return const PurchasesScreen();
          final itemId = int.tryParse(
            state.uri.queryParameters['itemId'] ?? '',
          );
          final fromCreate = state.uri.queryParameters['from'] == 'create';
          return ProductFormScreen(
            purchaseId: id,
            itemId: itemId,
            fromCreate: fromCreate,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settingsAppearance,
        name: AppearanceScreen.name,
        builder: (context, state) => const AppearanceScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsCreator,
        name: CreatorScreen.name,
        builder: (context, state) => const CreatorScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsAbout,
        name: AboutScreen.name,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsLegal,
        name: LegalScreen.name,
        builder: (context, state) => const LegalScreen(),
      ),
    ],
  );
});

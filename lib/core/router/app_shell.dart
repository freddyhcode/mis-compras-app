import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final selectedNavStyle = TextStyle(
      fontSize: AppTypography.navLabel.size,
      height: AppTypography.navLabel.height(),
      fontWeight: AppTypography.navLabel.weight,
    );
    final unselectedNavStyle = TextStyle(
      fontSize: AppTypography.navLabel.size,
      height: AppTypography.navLabel.height(),
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.outlineVariant)),
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: colors.surface,
          selectedItemColor: colors.primary,
          unselectedItemColor: colors.onSurfaceVariant,
          selectedFontSize: AppTypography.navLabel.size,
          unselectedFontSize: AppTypography.navLabel.size,
          selectedLabelStyle: selectedNavStyle,
          unselectedLabelStyle: unselectedNavStyle,
          selectedIconTheme: IconThemeData(size: 20, color: colors.primary),
          unselectedIconTheme: IconThemeData(
            size: 20,
            color: colors.onSurfaceVariant,
          ),
          onTap: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: l10n.tabsHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_outlined),
              label: l10n.tabsHistory,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart_outlined),
              label: l10n.tabsStats,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              label: l10n.tabsSettings,
            ),
          ],
        ),
      ),
    );
  }
}

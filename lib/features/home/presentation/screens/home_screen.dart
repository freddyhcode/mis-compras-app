import 'package:mis_compras_app/core/config/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/core/utils/money.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_detail_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_form_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_format.dart';
import 'package:mis_compras_app/features/purchases/presentation/widgets/purchase_card.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/empty_state.dart';
import 'package:mis_compras_app/shared/widgets/section.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(purchaseProvider);
    final colors = Theme.of(context).colorScheme;

    if (state.isLoading && state.purchases.isEmpty) {
      return Scaffold(
        appBar: AppTopBar(title: Branding.appName, brand: true),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.errorType != null && state.purchases.isEmpty) {
      return Scaffold(
        appBar: AppTopBar(title: Branding.appName, brand: true),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText(
                    l10n.errorsLoad,
                    variant: AppTextVariant.small,
                    color: colors.error,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: l10n.commonRetry,
                    variant: AppButtonVariant.secondary,
                    fullWidth: true,
                    onPressed: () {
                      ref.read(purchaseProvider.notifier).loadPurchases();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final now = DateTime.now();
    final key = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    final monthPurchases = state.purchases
        .where((purchase) => monthKey(purchase.purchasedAt) == key)
        .toList();
    final total = monthPurchases.fold(
      0,
      (sum, purchase) => sum + purchaseTotalClp(purchase),
    );
    final average = monthPurchases.isEmpty
        ? 0
        : (total / monthPurchases.length).round();
    final recent = state.purchases.take(5).toList();

    return Scaffold(
      appBar: AppTopBar(title: Branding.appName, brand: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            backgroundColor: colors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.homeMonthTotal,
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                AppText(
                  formatClp(total),
                  variant: AppTextVariant.display,
                  color: colors.primary,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: _Stat(
                        label: l10n.homePurchases,
                        value: '${monthPurchases.length}',
                      ),
                    ),
                    Expanded(
                      child: _Stat(
                        label: l10n.homeAverage,
                        value: formatClp(average),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.newPurchase,
            fullWidth: true,
            onPressed: () {
              context.pushNamed(PurchaseFormScreen.newName);
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Section(
            title: l10n.homeRecent,
            children: [
              if (recent.isEmpty)
                EmptyState(
                  title: l10n.purchasesEmptyTitle,
                  description: l10n.purchasesEmptyDescription,
                )
              else
                for (final purchase in recent)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: PurchaseCard(
                      purchase: purchase,
                      onTap: () {
                        context.pushNamed(
                          PurchaseDetailScreen.name,
                          pathParameters: {'id': '${purchase.id}'},
                        );
                      },
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          variant: AppTextVariant.caption,
          color: colors.onSurfaceVariant,
        ),
        const SizedBox(height: 2),
        AppText(value, variant: AppTextVariant.label),
      ],
    );
  }
}

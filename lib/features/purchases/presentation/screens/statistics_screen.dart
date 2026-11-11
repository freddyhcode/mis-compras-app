import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/core/utils/money.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_stats.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_chip.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/empty_state.dart';
import 'package:mis_compras_app/shared/widgets/section.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  static const String name = 'statistics';

  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  int _period = 6;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(purchaseProvider);
    final colors = Theme.of(context).colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;

    if (state.isLoading && state.purchases.isEmpty) {
      return Scaffold(
        appBar: AppTopBar(title: l10n.statisticsTitle, brand: true),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.purchases.isEmpty) {
      return Scaffold(
        appBar: AppTopBar(title: l10n.statisticsTitle, brand: true),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            EmptyState(
              title: l10n.statsEmptyTitle,
              description: l10n.statsEmptyDesc,
            ),
          ],
        ),
      );
    }

    final series = _period == 12
        ? yearMonthTotals(state.purchases, DateTime.now().year, languageCode)
        : monthTotals(state.purchases, _period, languageCode);
    final total = series.fold(0, (sum, entry) => sum + entry.total);
    final count = series.fold(0, (sum, entry) => sum + entry.count);
    final products = series.fold(0, (sum, entry) => sum + entry.products);
    final periodPurchases = purchasesInSeries(state.purchases, series);
    final categories = topCategories(periodPurchases);
    final periodLabel = switch (_period) {
      3 => l10n.statsPeriod3,
      12 => l10n.statsPeriod12,
      _ => l10n.statsPeriod6,
    };

    return Scaffold(
      appBar: AppTopBar(title: l10n.statisticsTitle, brand: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            backgroundColor: colors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.statsPeriodTotal(periodLabel),
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                AppText(
                  formatClp(total),
                  variant: AppTextVariant.display,
                  color: colors.primary,
                ),
                const SizedBox(height: AppSpacing.md),
                Container(height: 1, color: colors.outlineVariant),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _Stat(label: l10n.statsCount, value: '$count'),
                    ),
                    Expanded(
                      child: _Stat(
                        label: l10n.statsProducts,
                        value: '$products',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppChip(
                label: l10n.statsPeriod3,
                selected: _period == 3,
                onPressed: () => setState(() => _period = 3),
              ),
              AppChip(
                label: l10n.statsPeriod6,
                selected: _period == 6,
                onPressed: () => setState(() => _period = 6),
              ),
              AppChip(
                label: l10n.statsPeriod12,
                selected: _period == 12,
                onPressed: () => setState(() => _period = 12),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Section(
            title: l10n.statsMonths,
            children: [
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    for (var index = 0; index < series.length; index++) ...[
                      _MonthRow(entry: series[index]),
                      if (index < series.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm,
                          ),
                          child: Container(
                            height: 1,
                            color: colors.outlineVariant,
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Section(
            title: l10n.statsTopCategories,
            children: [
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    for (var index = 0; index < categories.length; index++) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              purchaseCategoryLabel(
                                l10n,
                                categories[index].category,
                              ),
                              variant: AppTextVariant.small,
                            ),
                          ),
                          AppText(
                            formatClp(categories[index].total),
                            variant: AppTextVariant.small,
                            color: colors.onSurfaceVariant,
                          ),
                        ],
                      ),
                      if (index < categories.length - 1)
                        const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
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

class _MonthRow extends StatelessWidget {
  const _MonthRow({required this.entry});

  final MonthTotal entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(entry.label, variant: AppTextVariant.label),
                AppText(
                  l10n.statsPurchaseCount(entry.count),
                  variant: AppTextVariant.caption,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          AppText(
            formatClp(entry.total),
            variant: AppTextVariant.label,
            color: entry.total > 0 ? null : colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

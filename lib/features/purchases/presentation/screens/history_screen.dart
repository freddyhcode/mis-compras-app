import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_detail_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';
import 'package:mis_compras_app/features/purchases/presentation/widgets/purchase_card.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_chip.dart';
import 'package:mis_compras_app/shared/widgets/app_input.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/empty_state.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  static const String name = 'history';

  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _search = '';
  String _category = 'all';

  List<PurchaseEntity> _filtered(PurchaseState state) {
    final term = _search.trim().toLowerCase();

    return state.purchases.where((purchase) {
      if (_category != 'all' && purchase.category != _category) {
        return false;
      }

      if (term.isEmpty) return true;

      final haystack = [
        purchase.title,
        purchase.merchant ?? '',
        purchase.notes ?? '',
        ...purchase.items.map((item) => item.name),
      ].join(' ').toLowerCase();

      return haystack.contains(term);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(purchaseProvider);
    final colors = Theme.of(context).colorScheme;
    final purchases = _filtered(state);
    final hasFilter = _search.isNotEmpty || _category != 'all';

    return Scaffold(
      appBar: AppTopBar(title: l10n.tabsHistory, brand: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppInput(
            label: l10n.historySearch,
            placeholder: l10n.historySearchHint,
            onChanged: (value) {
              setState(() => _search = value);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppChip(
                label: l10n.historyAll,
                selected: _category == 'all',
                onPressed: () {
                  setState(() => _category = 'all');
                },
              ),
              for (final category in purchaseCategories)
                AppChip(
                  label: purchaseCategoryLabel(l10n, category),
                  selected: _category == category,
                  onPressed: () {
                    setState(() => _category = category);
                  },
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (state.errorType != null)
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
                  const SizedBox(height: AppSpacing.sm),
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
          if (state.isLoading && state.purchases.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (purchases.isEmpty && state.errorType == null)
            hasFilter
                ? EmptyState(
                    title: l10n.historyEmptyTitle,
                    description: l10n.historyEmptyDescription,
                  )
                : EmptyState(
                    title: l10n.purchasesEmptyTitle,
                    description: l10n.purchasesEmptyDescription,
                  )
          else
            ...purchases.map(
              (purchase) => Padding(
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
            ),
        ],
      ),
    );
  }
}

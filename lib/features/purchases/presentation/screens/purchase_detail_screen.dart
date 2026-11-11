import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/services/share/share_service.dart';
import 'package:mis_compras_app/core/services/share/providers/share_service_provider.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/core/utils/date.dart';
import 'package:mis_compras_app/core/utils/money.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/features/home/presentation/screens/home_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/product_form_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_form_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_format.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_share_text.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_confirm_dialog.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/empty_state.dart';
import 'package:mis_compras_app/shared/widgets/section.dart';

class PurchaseDetailScreen extends ConsumerStatefulWidget {
  static const String name = 'purchaseDetail';

  const PurchaseDetailScreen({required this.purchaseId, super.key});

  final int purchaseId;

  @override
  ConsumerState<PurchaseDetailScreen> createState() =>
      _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends ConsumerState<PurchaseDetailScreen> {
  bool _deleting = false;
  bool _sharing = false;
  bool _duplicating = false;
  String? _error;
  String? _notice;

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(HomeScreen.name);
    }
  }

  void _openEdit(PurchaseEntity purchase) {
    context.pushNamed(
      PurchaseFormScreen.editName,
      pathParameters: {'id': '${purchase.id}'},
    );
  }

  void _openProduct(PurchaseEntity purchase, {PurchaseItemEntity? item}) {
    context.pushNamed(
      ProductFormScreen.name,
      pathParameters: {'id': '${purchase.id}'},
      queryParameters: item == null
          ? const {'from': 'detail'}
          : {'itemId': '${item.id}', 'from': 'detail'},
    );
  }

  Future<void> _handleShare(PurchaseEntity purchase) async {
    final l10n = AppLocalizations.of(context)!;
    final languageCode = Localizations.localeOf(context).languageCode;

    setState(() {
      _sharing = true;
      _error = null;
      _notice = null;
    });

    try {
      final text = buildPurchaseShareText(purchase, l10n, languageCode);
      final result = await ref
          .read(shareServiceProvider)
          .shareText(title: l10n.shareTitle, text: text);

      if (!mounted) return;

      setState(() {
        _sharing = false;
        if (result == AppShareResult.copied) {
          _notice = l10n.shareCopied;
        }
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _sharing = false;
        _error = l10n.shareError;
      });
    }
  }

  Future<void> _handleDuplicate(PurchaseEntity purchase) async {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _duplicating = true;
      _error = null;
      _notice = null;
    });

    final result = await ref
        .read(purchaseProvider.notifier)
        .duplicatePurchase(purchase.id!, suffix: l10n.purchaseDuplicateSuffix);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _duplicating = false;
          _error = l10n.errorsSave;
        });
      },
      (copy) {
        if (copy.id != null) {
          context.pushReplacementNamed(
            PurchaseDetailScreen.name,
            pathParameters: {'id': '${copy.id}'},
          );
        } else {
          setState(() => _duplicating = false);
        }
      },
    );
  }

  Future<void> _handleDelete(PurchaseEntity purchase) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showAppConfirmDialog(
      context: context,
      title: l10n.purchaseDeleteTitle,
      body: l10n.purchaseDeleteBody,
      primaryLabel: l10n.purchaseDeleteConfirm,
      secondaryLabel: l10n.commonCancel,
      danger: true,
    );

    if (!confirmed || !mounted) return;

    setState(() {
      _deleting = true;
      _error = null;
      _notice = null;
    });

    final result = await ref
        .read(purchaseProvider.notifier)
        .deletePurchase(purchase.id!);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _deleting = false;
          _error = l10n.errorsDelete;
        });
      },
      (deleted) {
        if (deleted) {
          _back();
        } else {
          setState(() {
            _deleting = false;
            _error = l10n.errorsDelete;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(purchaseProvider);
    final colors = Theme.of(context).colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;

    if (state.isLoading && state.purchases.isEmpty) {
      return Scaffold(
        appBar: AppTopBar(
          title: l10n.purchaseDetailTitle,
          showBack: true,
          onBack: _back,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final purchase = _findPurchase(state.purchases, widget.purchaseId);

    if (purchase == null) {
      return Scaffold(
        appBar: AppTopBar(
          title: l10n.purchaseDetailTitle,
          showBack: true,
          onBack: _back,
        ),
        body: EmptyState(
          title: l10n.purchaseNotFound,
          description: l10n.purchasesEmptyDescription,
          actionLabel: l10n.commonBack,
          onAction: _back,
        ),
      );
    }

    return Scaffold(
      appBar: AppTopBar(
        title: capitalizeText(purchase.title),
        showBack: true,
        onBack: _back,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.purchaseTotal,
                  variant: AppTextVariant.title,
                  color: colors.onSurfaceVariant,
                ),
                AppText(
                  formatClp(purchaseTotalClp(purchase)),
                  variant: AppTextVariant.display,
                  color: colors.primary,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: l10n.shareAction,
                        variant: AppButtonVariant.secondary,
                        loading: _sharing,
                        onPressed: () => _handleShare(purchase),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppButton(
                        label: l10n.purchaseEdit,
                        variant: AppButtonVariant.secondary,
                        onPressed: () => _openEdit(purchase),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Container(height: 1, color: colors.outlineVariant),
                const SizedBox(height: AppSpacing.md),
                AppText(
                  '${l10n.purchaseCreatedAt} ${formatDateTime(purchase.createdAt, l10n.localeName)}',
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: 2),
                AppText(
                  '${l10n.purchaseDate}: ${formatIsoDate(purchase.purchasedAt, l10n.localeName)}',
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                if (purchase.merchant != null) ...[
                  const SizedBox(height: 2),
                  AppText(
                    '${l10n.purchaseMerchant}: '
                    '${capitalizeText(purchase.merchant!)}',
                    variant: AppTextVariant.small,
                    color: colors.onSurfaceVariant,
                  ),
                ],
                const SizedBox(height: 2),
                AppText(
                  '${l10n.purchaseCategory}: '
                  '${purchaseCategoryLabel(l10n, purchase.category)}',
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                if (purchase.notes != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  AppText(
                    capitalizeText(purchase.notes!),
                    variant: AppTextVariant.small,
                    color: colors.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Section(
            title: l10n.purchaseProducts,
            children: [
              if (purchase.items.isEmpty)
                AppCard(
                  child: AppText(
                    l10n.purchaseNoProducts,
                    variant: AppTextVariant.small,
                    color: colors.onSurfaceVariant,
                  ),
                )
              else
                for (final item in purchase.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: AppCard(
                      onTap: () => _openProduct(purchase, item: item),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  capitalizeText(item.name),
                                  variant: AppTextVariant.label,
                                  maxLines: 1,
                                ),
                                AppText(
                                  '${formatQuantity(item.quantityMilli, item.unit, languageCode)} '
                                  '${unitName(l10n, item.unit, item.quantityMilli)} '
                                  '× ${formatClp(item.unitPriceClp)}',
                                  variant: AppTextVariant.small,
                                  color: colors.onSurfaceVariant,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          AppText(
                            formatClp(subtotalClp(item)),
                            variant: AppTextVariant.label,
                          ),
                        ],
                      ),
                    ),
                  ),
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: l10n.purchaseAddProduct,
                variant: AppButtonVariant.secondary,
                fullWidth: true,
                onPressed: () => _openProduct(purchase),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.md),
            AppText(
              _error!,
              variant: AppTextVariant.small,
              color: colors.error,
            ),
          ],
          if (_notice != null) ...[
            const SizedBox(height: AppSpacing.md),
            AppText(
              _notice!,
              variant: AppTextVariant.small,
              color: colors.primary,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: l10n.purchaseDuplicate,
                  variant: AppButtonVariant.secondary,
                  loading: _duplicating,
                  onPressed: () => _handleDuplicate(purchase),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: l10n.purchaseDeleteAction,
                  variant: AppButtonVariant.danger,
                  loading: _deleting,
                  onPressed: () => _handleDelete(purchase),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PurchaseEntity? _findPurchase(List<PurchaseEntity> purchases, int id) {
    for (final purchase in purchases) {
      if (purchase.id == id) return purchase;
    }
    return null;
  }
}

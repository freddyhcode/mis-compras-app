import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/utils/money.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/home/presentation/screens/home_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_detail_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_format.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_chip.dart';
import 'package:mis_compras_app/shared/widgets/app_confirm_dialog.dart';
import 'package:mis_compras_app/shared/widgets/app_input.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/empty_state.dart';
import 'package:mis_compras_app/shared/widgets/section.dart';

class ProductFormScreen extends ConsumerWidget {
  static const String name = 'productForm';

  const ProductFormScreen({
    required this.purchaseId,
    this.itemId,
    this.fromCreate = false,
    super.key,
  });

  final int purchaseId;
  final int? itemId;
  final bool fromCreate;

  void _backToPurchase(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else if (fromCreate) {
      context.goNamed(HomeScreen.name);
    } else {
      context.goNamed(
        PurchaseDetailScreen.name,
        pathParameters: {'id': '$purchaseId'},
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(purchaseProvider);

    if (state.isLoading && state.purchases.isEmpty) {
      return Scaffold(
        appBar: AppTopBar(
          title: l10n.productNewTitle,
          showBack: true,
          onBack: () => _backToPurchase(context),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final purchase = _findPurchase(state.purchases, purchaseId);

    if (purchase == null) {
      return Scaffold(
        appBar: AppTopBar(
          title: l10n.productNewTitle,
          showBack: true,
          onBack: () => context.goNamed(HomeScreen.name),
        ),
        body: EmptyState(
          title: l10n.purchaseNotFound,
          description: l10n.purchasesEmptyDescription,
          actionLabel: l10n.commonBack,
          onAction: () => context.goNamed(HomeScreen.name),
        ),
      );
    }

    final item = itemId == null ? null : _findItem(purchase.items, itemId!);

    if (itemId != null && item == null) {
      return Scaffold(
        appBar: AppTopBar(
          title: l10n.productEditTitle,
          showBack: true,
          onBack: () => context.goNamed(
            PurchaseDetailScreen.name,
            pathParameters: {'id': '$purchaseId'},
          ),
        ),
        body: EmptyState(
          title: l10n.purchaseNotFound,
          description: l10n.purchasesEmptyDescription,
          actionLabel: l10n.commonBack,
          onAction: () => context.goNamed(
            PurchaseDetailScreen.name,
            pathParameters: {'id': '$purchaseId'},
          ),
        ),
      );
    }

    return _ProductForm(
      key: ValueKey(item?.id ?? 'new'),
      purchase: purchase,
      item: item,
      fromCreate: fromCreate,
    );
  }

  PurchaseEntity? _findPurchase(List<PurchaseEntity> purchases, int id) {
    for (final purchase in purchases) {
      if (purchase.id == id) return purchase;
    }
    return null;
  }

  PurchaseItemEntity? _findItem(List<PurchaseItemEntity> items, int id) {
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }
}

class _ProductForm extends ConsumerStatefulWidget {
  const _ProductForm({
    required this.purchase,
    this.item,
    this.fromCreate = false,
    super.key,
  });

  final PurchaseEntity purchase;
  final PurchaseItemEntity? item;
  final bool fromCreate;

  @override
  ConsumerState<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<_ProductForm> {
  late final TextEditingController _name;
  late final TextEditingController _quantity;
  late final TextEditingController _price;

  late String _unit;
  bool _initialized = false;
  bool _saving = false;
  String? _notice;
  String? _error;
  String? _nameError;
  String? _quantityError;
  String? _priceError;

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else if (widget.fromCreate) {
      context.goNamed(HomeScreen.name);
    } else {
      context.goNamed(
        PurchaseDetailScreen.name,
        pathParameters: {'id': '${widget.purchase.id}'},
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(
      text: capitalizeText(widget.item?.name ?? ''),
    );
    _quantity = TextEditingController();
    _price = TextEditingController(
      text: widget.item == null ? '' : '${widget.item!.unitPriceClp}',
    );
    _unit = widget.item?.unit ?? 'un';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final languageCode = Localizations.localeOf(context).languageCode;
    _quantity.text = widget.item == null
        ? '1'
        : formatQuantityInput(widget.item!.quantityMilli, languageCode);
    _initialized = true;
  }

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _price.dispose();
    super.dispose();
  }

  int _quantityMilli() => parseQuantityInput(_quantity.text);

  int _unitPriceClp() => parseClpInput(_price.text);

  int _preview() => ((_quantityMilli() * _unitPriceClp()) / 1000).round();

  bool _validate() {
    final l10n = AppLocalizations.of(context)!;
    var valid = true;

    setState(() {
      _nameError = null;
      _quantityError = null;
      _priceError = null;
    });

    if (_name.text.trim().isEmpty) {
      _nameError = l10n.productInvalidName;
      valid = false;
    }
    if (_quantityMilli() <= 0) {
      _quantityError = l10n.productInvalidQuantity;
      valid = false;
    } else if (_unit == 'un' && _quantityMilli() % 1000 != 0) {
      _quantityError = l10n.productInvalidInteger;
      valid = false;
    }
    if (_unitPriceClp() < 0) {
      _priceError = l10n.productInvalidPrice;
      valid = false;
    }

    if (!valid) setState(() {});
    return valid;
  }

  Future<void> _handleSave({required bool andAdd}) async {
    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _error = null;
      _notice = null;
    });

    if (!_validate()) return;

    setState(() => _saving = true);

    final notifier = ref.read(purchaseProvider.notifier);
    final item = widget.item;

    final result = item != null
        ? await notifier.updateItem(
            item,
            name: _name.text,
            quantityMilli: _quantityMilli(),
            unit: _unit,
            unitPriceClp: _unitPriceClp(),
          )
        : await notifier.addItem(
            purchaseId: widget.purchase.id!,
            name: _name.text,
            quantityMilli: _quantityMilli(),
            unit: _unit,
            unitPriceClp: _unitPriceClp(),
          );

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _saving = false;
          _error = l10n.errorsSave;
        });
      },
      (saved) {
        if (item != null) {
          context.pop();
          return;
        }

        if (andAdd) {
          setState(() {
            _saving = false;
            _notice = l10n.purchaseSaved;
            _name.clear();
            _quantity.text = '1';
            _unit = 'un';
            _price.clear();
          });
        } else if (widget.fromCreate) {
          context.pushReplacementNamed(
            PurchaseDetailScreen.name,
            pathParameters: {'id': '${widget.purchase.id}'},
          );
        } else {
          context.pop();
        }
      },
    );
  }

  Future<void> _handleDelete() async {
    final l10n = AppLocalizations.of(context)!;
    final item = widget.item;
    if (item == null) return;

    final confirmed = await showAppConfirmDialog(
      context: context,
      title: l10n.productDeleteTitle,
      body: l10n.productDeleteBody,
      primaryLabel: l10n.productDeleteConfirm,
      secondaryLabel: l10n.commonCancel,
      danger: true,
    );

    if (!confirmed || !mounted) return;

    setState(() {
      _saving = true;
      _error = null;
    });

    final result = await ref
        .read(purchaseProvider.notifier)
        .removeItem(item.purchaseId, item.id!);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _saving = false;
          _error = l10n.errorsDelete;
        });
      },
      (saved) {
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppTopBar(
        title: widget.item == null
            ? l10n.productNewTitle
            : l10n.productEditTitle,
        showBack: true,
        onBack: _back,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Section(
            title: l10n.productFormTitle,
            children: [
              AppInput(
                label: l10n.productName,
                placeholder: l10n.productNamePlaceholder,
                controller: _name,
                required: true,
                requiredText: l10n.commonRequired,
                maxLength: 80,
                textCapitalization: TextCapitalization.sentences,
                error: _nameError,
                onChanged: (_) {
                  if (_nameError != null) {
                    setState(() => _nameError = null);
                  }
                },
              ),
              const SizedBox(height: 16),
              AppInput(
                label: l10n.productQuantity,
                controller: _quantity,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                ],
                help: _unit == 'un'
                    ? l10n.productIntegerHelp
                    : l10n.productDecimalHelp,
                required: true,
                requiredText: l10n.commonRequired,
                error: _quantityError,
                onChanged: (_) {
                  setState(() {
                    _quantityError = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              AppText(l10n.productUnit, variant: AppTextVariant.label),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final unit in purchaseUnits)
                    AppChip(
                      label: unitOptionLabel(l10n, unit),
                      selected: _unit == unit,
                      onPressed: () {
                        setState(() => _unit = unit);
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              AppInput(
                label: l10n.productPrice,
                controller: _price,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                help: '${l10n.productSubtotal}: ${formatClp(_preview())}',
                error: _priceError,
                onChanged: (_) {
                  setState(() {
                    _priceError = null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppCard(
            backgroundColor: colors.primaryContainer,
            borderColor: colors.outlineVariant,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.productSubtotal,
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                AppText(
                  formatClp(_preview()),
                  variant: AppTextVariant.title,
                  color: colors.primary,
                ),
              ],
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            AppText(
              _error!,
              variant: AppTextVariant.small,
              color: colors.error,
            ),
          ],
          if (_notice != null) ...[
            const SizedBox(height: 12),
            AppText(
              _notice!,
              variant: AppTextVariant.small,
              color: colors.primary,
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: l10n.productSave,
                  loading: _saving,
                  onPressed: () => _handleSave(andAdd: false),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: widget.item == null
                    ? AppButton(
                        label: l10n.productSaveAndAdd,
                        variant: AppButtonVariant.secondary,
                        onPressed: _saving
                            ? null
                            : () => _handleSave(andAdd: true),
                      )
                    : AppButton(
                        label: l10n.productDeleteAction,
                        variant: AppButtonVariant.danger,
                        onPressed: _saving ? null : _handleDelete,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

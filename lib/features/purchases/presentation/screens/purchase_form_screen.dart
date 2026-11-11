import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/core/utils/date.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/home/presentation/screens/home_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/history_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/product_form_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/screens/purchase_detail_screen.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_chip.dart';
import 'package:mis_compras_app/shared/widgets/app_date_field.dart';
import 'package:mis_compras_app/shared/widgets/app_input.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/empty_state.dart';

class PurchaseFormScreen extends ConsumerWidget {
  static const String newName = 'purchaseNew';
  static const String editName = 'purchaseEdit';

  const PurchaseFormScreen({this.purchaseId, super.key});

  final int? purchaseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(purchaseProvider);

    if (purchaseId == null) {
      return const _PurchaseForm();
    }

    if (state.isLoading && state.purchases.isEmpty) {
      return Scaffold(
        appBar: AppTopBar(
          title: l10n.purchaseEditTitle,
          showBack: true,
          onBack: () => context.goNamed(HistoryScreen.name),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final purchase = _findPurchase(state.purchases, purchaseId!);

    if (purchase == null) {
      return Scaffold(
        appBar: AppTopBar(
          title: l10n.purchaseEditTitle,
          showBack: true,
          onBack: () => context.goNamed(HistoryScreen.name),
        ),
        body: EmptyState(
          title: l10n.purchaseNotFound,
          description: l10n.purchasesEmptyDescription,
          actionLabel: l10n.commonBack,
          onAction: () => context.goNamed(HistoryScreen.name),
        ),
      );
    }

    return _PurchaseForm(key: ValueKey(purchase.id), purchase: purchase);
  }

  PurchaseEntity? _findPurchase(List<PurchaseEntity> purchases, int id) {
    for (final purchase in purchases) {
      if (purchase.id == id) return purchase;
    }
    return null;
  }
}

class _PurchaseForm extends ConsumerStatefulWidget {
  const _PurchaseForm({this.purchase, super.key});

  final PurchaseEntity? purchase;

  @override
  ConsumerState<_PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends ConsumerState<_PurchaseForm> {
  late final TextEditingController _title;
  late final TextEditingController _merchant;
  late final TextEditingController _notes;

  late DateTime _purchasedAt;
  late String _category;
  bool _saving = false;
  String? _error;
  String? _titleError;

  bool _isEditing() => widget.purchase != null;

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else if (_isEditing()) {
      context.goNamed(
        PurchaseDetailScreen.name,
        pathParameters: {'id': '${widget.purchase!.id}'},
      );
    } else {
      context.goNamed(HomeScreen.name);
    }
  }

  @override
  void initState() {
    super.initState();
    final purchase = widget.purchase;

    _title = TextEditingController(text: capitalizeText(purchase?.title ?? ''));
    _purchasedAt = parseIsoDate(purchase?.purchasedAt ?? '') ?? DateTime.now();
    _merchant = TextEditingController(
      text: capitalizeText(purchase?.merchant ?? ''),
    );
    _notes = TextEditingController(text: capitalizeText(purchase?.notes ?? ''));
    _category = purchase?.category ?? 'otros';
  }

  @override
  void dispose() {
    _title.dispose();
    _merchant.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final l10n = AppLocalizations.of(context)!;

    final picked = await showDatePicker(
      context: context,
      initialDate: _purchasedAt,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100, 12, 31),
      helpText: l10n.purchaseDate,
      cancelText: l10n.commonCancel,
      confirmText: l10n.commonAccept,
      fieldLabelText: l10n.purchaseDate,
      fieldHintText: l10n.purchaseDateHelp,
      errorFormatText: l10n.purchaseInvalidDate,
      errorInvalidText: l10n.purchaseInvalidDate,
      builder: (context, child) {
        final theme = Theme.of(context);
        final buttonStyle = TextButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          textStyle: TextStyle(
            fontSize: AppTypography.label.size,
            fontWeight: AppTypography.label.weight,
          ),
        );

        return Theme(
          data: theme.copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: theme.colorScheme.surface,
              headerBackgroundColor: theme.colorScheme.primaryContainer,
              headerForegroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              cancelButtonStyle: buttonStyle,
              confirmButtonStyle: buttonStyle,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      setState(() => _purchasedAt = picked);
    }
  }

  Future<void> _handleSave() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _error = null;
      _titleError = null;
    });

    if (_title.text.trim().isEmpty) {
      setState(() => _titleError = l10n.purchaseInvalidTitle);
      return;
    }

    setState(() => _saving = true);

    final merchant = _merchant.text.trim();
    final notes = _notes.text.trim();
    final notifier = ref.read(purchaseProvider.notifier);

    final result = _isEditing()
        ? await notifier.updatePurchase(
            widget.purchase!,
            title: _title.text,
            purchasedAt: toIsoDate(_purchasedAt),
            merchant: merchant.isEmpty ? null : merchant,
            category: _category,
            notes: notes.isEmpty ? null : notes,
          )
        : await notifier.createPurchase(
            title: _title.text,
            purchasedAt: toIsoDate(_purchasedAt),
            merchant: merchant.isEmpty ? null : merchant,
            category: _category,
            notes: notes.isEmpty ? null : notes,
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
        if (_isEditing()) {
          context.pop();
          return;
        }

        if (saved.id != null) {
          context.pushReplacementNamed(
            ProductFormScreen.name,
            pathParameters: {'id': '${saved.id}'},
            queryParameters: {'from': 'create'},
          );
        } else {
          context.goNamed(HomeScreen.name);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppTopBar(
        title: _isEditing() ? l10n.purchaseEditTitle : l10n.purchaseNewTitle,
        showBack: true,
        onBack: _back,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppInput(
            label: l10n.purchaseTitleLabel,
            placeholder: l10n.purchaseTitlePlaceholder,
            controller: _title,
            required: true,
            requiredText: l10n.commonRequired,
            maxLength: 80,
            textCapitalization: TextCapitalization.sentences,
            error: _titleError,
            onChanged: (_) {
              if (_titleError != null) {
                setState(() => _titleError = null);
              }
            },
          ),
          const SizedBox(height: 16),
          AppDateField(
            label: l10n.purchaseDate,
            value: _purchasedAt,
            requiredText: l10n.commonRequired,
            onTap: _pickDate,
          ),
          const SizedBox(height: 16),
          AppInput(
            label: l10n.purchaseMerchant,
            placeholder: l10n.purchaseMerchantPlaceholder,
            controller: _merchant,
            maxLength: 80,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 16),
          AppText(l10n.purchaseCategory, variant: AppTextVariant.label),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
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
          const SizedBox(height: 16),
          AppInput(
            label: l10n.purchaseNotes,
            placeholder: l10n.purchaseNotesPlaceholder,
            controller: _notes,
            multiline: true,
            maxLength: 500,
            textCapitalization: TextCapitalization.sentences,
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            AppText(
              _error!,
              variant: AppTextVariant.small,
              color: colors.error,
            ),
          ],
          const SizedBox(height: 24),
          AppButton(
            label: l10n.purchaseSave,
            fullWidth: true,
            loading: _saving,
            onPressed: _handleSave,
          ),
        ],
      ),
    );
  }
}

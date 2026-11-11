import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/shared/widgets/empty_state.dart';

class PurchasesScreen extends StatelessWidget {
  static const String name = 'purchases';

  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.purchasesTitle)),
      body: EmptyState(
        title: l10n.purchasesEmptyTitle,
        description: l10n.purchasesEmptyDescription,
      ),
    );
  }
}

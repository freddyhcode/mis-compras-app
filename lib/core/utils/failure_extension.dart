import 'package:mis_compras_app/core/errors/database_error_type.dart';
import 'package:mis_compras_app/core/errors/failure.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';

String getMessageError(Failure failure, AppLocalizations l10n) {
  if (failure is DatabaseFailure) {
    return switch (failure.errorType) {
      DatabaseErrorType.getFailed => l10n.errorsLoad,
      DatabaseErrorType.insertFailed => l10n.errorsSave,
      DatabaseErrorType.updateFailed => l10n.errorsSave,
      DatabaseErrorType.deleteFailed => l10n.errorsDelete,
    };
  }

  return l10n.errorsLoad;
}

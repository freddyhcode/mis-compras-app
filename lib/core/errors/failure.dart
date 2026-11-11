// Core Failure definitions for Clean Architecture error handling.
///
/// Author: freddyhcode
library;

import 'database_error_type.dart';

abstract class Failure {
  const Failure();
}

/// Represents a failure originating from database operations (SQLite).
class DatabaseFailure extends Failure {
  final DatabaseErrorType errorType;
  const DatabaseFailure(this.errorType);
}

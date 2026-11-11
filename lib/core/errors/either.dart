/// Pure Dart Functional Error Handling (Either Pattern).
///
/// Provides a zero-dependency structure for functional error handling in Clean Architecture.
/// - [Left]: Failure / Error (`L`)
/// - [Right]: Success / Data (`R`)
///
/// Author: freddyhcode
library;

/// Functional Programming data structure representing a value of one of two possible types.
/// - [Left]: Represents a failure or error (`L`).
/// - [Right]: Represents a successful result (`R`).
abstract class Either<L, R> {
  const Either();

  /// Unpacks the result by executing [onLeft] if this is a [Left] (Failure),
  /// or [onRight] if this is a [Right] (Success).
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);
}

/// Represents the Left (Failure) side of an [Either].
class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onLeft(value);
  }
}

/// Represents the Right (Success) side of an [Either].
class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onRight(value);
  }
}

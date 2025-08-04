import 'package:equatable/equatable.dart';
import 'package:flutter_map_clean_arch/core/errors/failures.dart';

// A custom Result class to handle success and failure states without dartz.
// Using a sealed class ensures that we must handle both Success and Error cases.
sealed class Result<S, F extends Failure> extends Equatable {
  const Result();
}

final class Success<S, F extends Failure> extends Result<S, F> {
  final S data;
  const Success(this.data);

  @override
  List<Object?> get props => [data];
}

final class Error<S, F extends Failure> extends Result<S, F> {
  final F failure;
  const Error(this.failure);

  @override
  List<Object?> get props => [failure];
}


// Abstract class for Use Cases.
// It defines a standard contract for all use cases in the app.
// 'Type' is the return type of the use case (e.g., a LocationEntity).
// 'Params' is the input parameter type (e.g., NoParams if no input is needed).
abstract class UseCase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}

// A helper class to be used when a use case doesn't require any parameters.
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
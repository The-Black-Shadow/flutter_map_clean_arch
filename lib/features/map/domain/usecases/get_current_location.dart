import 'package:flutter_map_clean_arch/core/errors/failures.dart';
import 'package:flutter_map_clean_arch/core/usecases/usecase.dart';
import 'package:flutter_map_clean_arch/features/map/domain/entities/location_entity.dart';
import 'package:flutter_map_clean_arch/features/map/domain/repositories/map_repository.dart';

// This is a concrete use case that represents a single business interaction.
class GetCurrentLocation implements UseCase<LocationEntity, NoParams> {
  final MapRepository repository;

  // The use case depends on the repository contract, not the implementation.
  // This is Dependency Inversion, a key principle of clean architecture.
  GetCurrentLocation(this.repository);

  /// This is the method that will be called from the presentation layer (BLoC).
  @override
  Future<Result<LocationEntity, Failure>> call(NoParams params) async {
    // Here we could add additional business logic, validation, etc.
    // For now, we just delegate the call to the repository.
    return await repository.getCurrentLocation();
  }
}
import 'package:flutter_map_clean_arch/core/errors/failures.dart';
import 'package:flutter_map_clean_arch/core/usecases/usecase.dart';
import 'package:flutter_map_clean_arch/features/map/domain/entities/location_entity.dart';

// This is the contract (interface) for our data layer.
// The domain layer defines WHAT needs to be done, but not HOW.
// The 'HOW' (the implementation) will be in the data layer.
abstract class MapRepository {
  /// Gets the current user's geographical location.
  /// Returns a [Failure] if something goes wrong.
  /// Otherwise, returns a [LocationEntity].
  Future<Result<LocationEntity, Failure>> getCurrentLocation();
}

import 'package:flutter_map_clean_arch/features/map/domain/entities/location_entity.dart';
import 'package:geolocator/geolocator.dart';

// The LocationModel is a data transfer object (DTO).
// It extends the LocationEntity to inherit its properties, but also includes
// logic for converting data from external sources (like a Position object)
// into our application's entity.
class LocationModel extends LocationEntity {
  const LocationModel({required super.latitude, required super.longitude});

  // Factory constructor to create a LocationModel from the geolocator's Position object.
  factory LocationModel.fromPosition(Position position) {
    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}

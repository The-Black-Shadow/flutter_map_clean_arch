import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_clean_arch/core/errors/exceptions.dart';
import 'package:flutter_map_clean_arch/features/map/data/models/location_model.dart';

// Abstract contract for the remote data source.
// This defines what methods are available for fetching map-related data from an external source.
abstract class MapRemoteDataSource {
  /// Gets the current user's location from the device.
  ///
  /// Throws a [LocationException] for all error cases.
  Future<LocationModel> getCurrentLocation();
}

// Concrete implementation of the remote data source contract.
class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final GeolocatorPlatform geolocator;

  MapRemoteDataSourceImpl({required this.geolocator});

  @override
  Future<LocationModel> getCurrentLocation() async {
    // Check for location service availability and permissions.
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Location services are disabled.');
    }

    permission = await geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      final position = await geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return LocationModel.fromPosition(position);
    } catch (e) {
      // Catch any other potential errors from the geolocator plugin.
      throw LocationException(
        'Failed to get current location: ${e.toString()}',
      );
    }
  }
}

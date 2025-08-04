import 'package:equatable/equatable.dart';

// This is our core business object (Entity).
// It represents a geographical location and is independent of any data source.
// We use Equatable to allow for easy value comparison.
class LocationEntity extends Equatable {
  final double latitude;
  final double longitude;

  const LocationEntity({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}

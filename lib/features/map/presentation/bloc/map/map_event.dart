part of 'map_bloc.dart';

// Sealed class for all events related to the map.
// Using a sealed class ensures we handle all possible events.
sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

// Event to signal that the user's current location should be fetched.
final class GetCurrentLocationEvent extends MapEvent {}

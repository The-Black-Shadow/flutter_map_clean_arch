part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();
  
  @override
  List<Object> get props => [];
}

// Initial state, before any action has been taken.
final class MapInitial extends MapState {}

// State indicating that the location is being fetched.
final class MapLoading extends MapState {}

// State indicating that the location was successfully fetched.
final class MapLocationLoaded extends MapState {
  final LocationEntity location;

  const MapLocationLoaded(this.location);

  @override
  List<Object> get props => [location];
}

// State indicating that an error occurred while fetching the location.
final class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object> get props => [message];
}

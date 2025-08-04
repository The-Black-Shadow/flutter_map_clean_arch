import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_clean_arch/core/usecases/usecase.dart';
import 'package:flutter_map_clean_arch/features/map/domain/entities/location_entity.dart';
import 'package:flutter_map_clean_arch/features/map/domain/usecases/get_current_location.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCurrentLocation getCurrentLocation;

  MapBloc({required this.getCurrentLocation}) : super(MapInitial()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
  }

  // Handles the GetCurrentLocationEvent.
  Future<void> _onGetCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<MapState> emit,
  ) async {
    // Emit a loading state to notify the UI.
    emit(MapLoading());

    // Execute the use case to get the current location.
    final result = await getCurrentLocation(NoParams());

    // Handle the result using a switch expression on the sealed Result class.
    // This ensures we handle both success and failure cases.
    switch (result) {
      case Success(data: final location):
        // On success, emit the MapLocationLoaded state with the location data.
        emit(MapLocationLoaded(location));
      case Error(failure: final failure):
        // On failure, emit the MapError state with the failure message.
        emit(MapError(failure.message));
    }
  }
}

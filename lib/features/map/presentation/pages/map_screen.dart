import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_clean_arch/features/map/presentation/bloc/map/map_bloc.dart';
import 'package:flutter_map_clean_arch/injection_container.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    // Using BlocProvider to provide the MapBloc to the widget tree.
    // We use the service locator 'sl' to get the BLoC instance.
    return BlocProvider(
      create: (_) => sl<MapBloc>()..add(GetCurrentLocationEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps'),
          backgroundColor: Colors.blue.shade700,
        ),
        body: BlocConsumer<MapBloc, MapState>(
          // The listener is used for side effects like showing SnackBars or dialogs.
          listener: (context, state) {
            if (state is MapError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is MapLocationLoaded) {
              // When location is loaded, animate the camera to the new position.
              _goToLocation(state.location.latitude, state.location.longitude);
            }
          },
          // The builder is used to build the UI based on the current state.
          builder: (context, state) {
            if (state is MapLoading || state is MapInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            // For both loaded and error states, we show the map.
            // If there's an error, the map will just be at its initial position.
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true, // Shows the blue dot for user's location
              myLocationButtonEnabled:
                  true, // Shows the button to center on user's location
            );
          },
        ),
      ),
    );
  }

  // Helper method to animate the map camera to a specific location.
  Future<void> _goToLocation(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16),
      ),
    );
  }
}

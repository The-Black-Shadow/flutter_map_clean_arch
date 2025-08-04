import 'package:flutter_map_clean_arch/features/map/presentation/bloc/map/map_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_clean_arch/features/map/data/datasources/map_remote_data_source.dart';
import 'package:flutter_map_clean_arch/features/map/data/repositories/map_repository_impl.dart';
import 'package:flutter_map_clean_arch/features/map/domain/repositories/map_repository.dart';
import 'package:flutter_map_clean_arch/features/map/domain/usecases/get_current_location.dart';

// Service Locator instance
final sl = GetIt.instance;

// Initializes all the dependencies for the application.
Future<void> init() async {
  // BLoC
  // We register it as a factory because we want a new instance of the BLoC
  // every time we need one, for example, when a user navigates to the map screen.
  sl.registerFactory(() => MapBloc(getCurrentLocation: sl()));

  // Use Cases
  // Use cases are usually registered as lazy singletons because they don't hold any state
  // and can be reused across the app.
  sl.registerLazySingleton(() => GetCurrentLocation(sl()));

  // Repositories
  // The repository is also a lazy singleton. It depends on the data source.
  sl.registerLazySingleton<MapRepository>(
    () => MapRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  // The data source depends on an external package (Geolocator).
  sl.registerLazySingleton<MapRemoteDataSource>(
    () => MapRemoteDataSourceImpl(geolocator: sl()),
  );

  // External
  // Registering the external geolocator package as a lazy singleton.
  sl.registerLazySingleton<GeolocatorPlatform>(
    () => GeolocatorPlatform.instance,
  );
}

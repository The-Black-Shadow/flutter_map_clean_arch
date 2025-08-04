import 'package:flutter_map_clean_arch/core/errors/exceptions.dart';
import 'package:flutter_map_clean_arch/core/errors/failures.dart';
import 'package:flutter_map_clean_arch/core/usecases/usecase.dart';
import 'package:flutter_map_clean_arch/features/map/data/datasources/map_remote_data_source.dart';
import 'package:flutter_map_clean_arch/features/map/domain/entities/location_entity.dart';
import 'package:flutter_map_clean_arch/features/map/domain/repositories/map_repository.dart';

// This is the concrete implementation of the MapRepository contract from the domain layer.
class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;
  // We could also inject a localDataSource here if we needed to cache data.

  MapRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<LocationEntity, Failure>> getCurrentLocation() async {
    try {
      // Call the data source to get the raw location data (LocationModel).
      final locationModel = await remoteDataSource.getCurrentLocation();
      // The repository's job is to convert the data model into a domain entity.
      // In this case, LocationModel is already a LocationEntity, so we can return it directly.
      return Success(locationModel);
    } on LocationException catch (e) {
      // The repository catches specific exceptions from the data source
      // and converts them into domain-level Failures.
      return Error(LocationFailure(e.message));
    } on ServerException catch (e) {
      // Example of handling another type of exception if we had a network call.
      return Error(ServerFailure(e.message));
    }
  }
}

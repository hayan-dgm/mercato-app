import 'package:dartz/dartz.dart';
import 'package:mercato_app/core/error/exceptions.dart';
import 'package:mercato_app/core/error/failures.dart';
import 'package:mercato_app/core/network/network_info.dart';
import 'package:mercato_app/features/drugs/data/models/drug_model.dart';
import 'package:mercato_app/features/drugs/domain/entities/drug.dart';
import 'package:mercato_app/features/drugs/domain/repositories/drugs_repository.dart';

import '../../domain/entities/image.dart';
import '../datasources/drug_local_datasource.dart';
import '../datasources/drug_remote_datasource.dart';
import '../models/image_model.dart';


typedef Future<Unit>UpdateDrugsMsg();

class DrugsRepositoryImpl implements DrugsRepository{

  final DrugRemoteDataSource remoteDataSource;
  final DrugLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  DrugsRepositoryImpl({required this.remoteDataSource,required this.localDataSource,required this.networkInfo,});

  @override
  Future<Either<Failure, List<Drug>>> getAllDrugs(query)async {
    if(await networkInfo.isConnected){
      try {
          final remoteDrugs = await remoteDataSource.getAllDrugs(query);
          localDataSource.cacheDrugs(remoteDrugs);
          return Right(remoteDrugs);
      } on ServerException {

        return Left(ServerFailure());
      }
    }else{
      try {
          final localDrugs = await localDataSource.getCachedDrugs();

          return Right(localDrugs);

      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }

  }

  @override
  Future<Either<Failure, Unit>> updateDrugs(Images image) async{
  
  final ImageModel imageModel = ImageModel(
        id: image.id,
        uri: image.uri,
        name: image.name,
        type: image.type,
            );

    return await _getMessage((){

    return remoteDataSource.updateDrugs(imageModel);
  });
 
  }

  Future<Either<Failure, Unit>> _getMessage(
    UpdateDrugsMsg updateDrugsMsg)async{

      if(await networkInfo.isConnected){
    try {
      await updateDrugsMsg();
      return Right(unit);

    } on ServerException {
      return Left(ServerFailure());
    }

  }else{
    return Left(OfflineFailure());
  }

  }

}
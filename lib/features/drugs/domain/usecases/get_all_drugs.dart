import 'package:dartz/dartz.dart';
import 'package:mercato_app/core/error/failures.dart';
import 'package:mercato_app/features/drugs/domain/entities/drug.dart';
import 'package:mercato_app/features/drugs/domain/repositories/drugs_repository.dart';

class GetAllDrugsUseCase{
  final DrugsRepository repository;

  GetAllDrugsUseCase(this.repository );
  
  Future<Either<Failure, List<Drug>>>call(String query)async{
    return await repository.getAllDrugs(query);
  }
}
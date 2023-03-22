import 'package:dartz/dartz.dart';
import 'package:mercato_app/core/error/failures.dart';
import 'package:mercato_app/features/drugs/domain/entities/drug.dart';
import 'package:mercato_app/features/drugs/domain/repositories/drugs_repository.dart';

class UpdateDrugUseCase{

  final DrugsRepository repository;
  UpdateDrugUseCase(this.repository);

  Future<Either<Failure, Unit>>call(Drug drug)async{
    return await repository.updateDrugs(drug);

  }

}
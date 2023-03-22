import 'package:dartz/dartz.dart';
import 'package:mercato_app/core/error/failures.dart';

import '../entities/drug.dart';

abstract class DrugsRepository {

  Future<Either<Failure, List<Drug>>>getAllDrugs(String query);
  Future<Either<Failure, Unit>>updateDrugs(Drug drug);
}